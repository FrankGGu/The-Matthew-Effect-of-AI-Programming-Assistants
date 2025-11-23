-module(course_schedule_iv).
-export([possible_courses/2]).

possible_courses(Courses, Queries) ->
    Graph = build_graph(Courses),
    InDegree = build_indegree(Courses),
    TopoOrder = topological_sort(Graph, InDegree),
    {InDegreeMap, ReverseGraph} = build_indegree_and_reverse_graph(Courses),
    Predecessors = build_predecessors(ReverseGraph),
    Results = [check_query(TopoOrder, Predecessors, Query) || Query <- Queries],
    Results.

build_graph(Courses) ->
    lists:foldl(fun({A, B}, Acc) ->
        case maps:is_key(A, Acc) of
            true -> maps:update(A, [B | maps:get(A, Acc)], Acc);
            false -> maps:put(A, [B], Acc)
        end
    end, #{}, Courses).

build_indegree(Courses) ->
    InDegree = lists:foldl(fun({_, B}, Acc) ->
        case maps:is_key(B, Acc) of
            true -> maps:update(B, maps:get(B, Acc) + 1, Acc);
            false -> maps:put(B, 1, Acc)
        end
    end, #{}, Courses),
    lists:foldl(fun(Course, Acc) ->
        case maps:is_key(Course, Acc) of
            true -> Acc;
            false -> maps:put(Course, 0, Acc)
        end
    end, InDegree, lists:usort([A || {A, _} <- Courses] ++ [B || {_, B} <- Courses])).

topological_sort(Graph, InDegree) ->
    Queue = lists:filter(fun(K) -> maps:get(K, InDegree) == 0 end, maps:keys(InDegree)),
    topological_sort_helper(Queue, Graph, InDegree, []).

topological_sort_helper([], _, _, Result) ->
    lists:reverse(Result);
topological_sort_helper([Node | Rest], Graph, InDegree, Result) ->
    NewResult = [Node | Result],
    case maps:is_key(Node, Graph) of
        true ->
            lists:foreach(fun(Child) ->
                NewCount = maps:get(Child, InDegree) - 1,
                InDegree1 = maps:put(Child, NewCount, InDegree),
                if
                    NewCount == 0 -> topological_sort_helper([Child | Rest], Graph, InDegree1, NewResult);
                    true -> topological_sort_helper(Rest, Graph, InDegree1, NewResult)
                end
            end, maps:get(Node, Graph));
        false -> topological_sort_helper(Rest, Graph, InDegree, NewResult)
    end.

build_indegree_and_reverse_graph(Courses) ->
    InDegree = lists:foldl(fun({_, B}, Acc) ->
        case maps:is_key(B, Acc) of
            true -> maps:update(B, maps:get(B, Acc) + 1, Acc);
            false -> maps:put(B, 1, Acc)
        end
    end, #{}, Courses),
    ReverseGraph = lists:foldl(fun({A, B}, Acc) ->
        case maps:is_key(B, Acc) of
            true -> maps:update(B, [A | maps:get(B, Acc)], Acc);
            false -> maps:put(B, [A], Acc)
        end
    end, #{}, Courses),
    {InDegree, ReverseGraph}.

build_predecessors(ReverseGraph) ->
    maps:map(fun(_, Nodes) -> lists:usort(Nodes) end, ReverseGraph).

check_query(TopoOrder, Predecessors, {Course, Target}) ->
    case lists:member(Course, TopoOrder) of
        false -> false;
        true ->
            Preds = maps:get(Course, Predecessors, []),
            is_reachable(Preds, Target, TopoOrder)
    end.

is_reachable([], _, _) -> false;
is_reachable([Pred | Rest], Target, TopoOrder) ->
    case Pred == Target of
        true -> true;
        false ->
            case lists:member(Pred, TopoOrder) of
                true ->
                    PredPreds = maps:get(Pred, Predecessors, []),
                    case is_reachable(PredPreds, Target, TopoOrder) of
                        true -> true;
                        false -> is_reachable(Rest, Target, TopoOrder)
                    end;
                false -> is_reachable(Rest, Target, TopoOrder)
            end
    end.