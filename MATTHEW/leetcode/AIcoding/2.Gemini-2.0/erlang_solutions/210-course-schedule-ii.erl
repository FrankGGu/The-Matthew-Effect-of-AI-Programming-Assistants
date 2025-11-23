-module(course_schedule_ii).
-export([findOrder/2]).

findOrder(NumCourses, Prerequisites) ->
    graph_from_edges(Prerequisites, NumCourses, Graph),
    topological_sort(Graph, NumCourses).

graph_from_edges(Edges, NumCourses, Graph) ->
    lists:foldl(
        fun({Course, Pre}, Acc) ->
            case maps:is_key(Pre, Acc) of
                true ->
                    maps:update(Pre, [Course | maps:get(Pre, Acc)], Acc);
                false ->
                    maps:put(Pre, [Course], Acc)
            end
        end,
        maps:new(),
        Edges
    ).

topological_sort(Graph, NumCourses) ->
    {InDegree, ZeroDegreeNodes} = calculate_in_degrees(Graph, NumCourses),
    do_topological_sort(Graph, InDegree, ZeroDegreeNodes, [], NumCourses).

calculate_in_degrees(Graph, NumCourses) ->
    InDegree = lists:foldl(
        fun(I, Acc) ->
            maps:put(I, 0, Acc)
        end,
        maps:new(),
        lists:seq(0, NumCourses - 1)
    ),
    InDegreeWithEdges = lists:foldl(
        fun({Node, Dests}, Acc) ->
            lists:foldl(
                fun(Dest, Acc2) ->
                    case maps:is_key(Dest, Acc2) of
                        true ->
                            maps:update(Dest, maps:get(Dest, Acc2) + 1, Acc2);
                        false ->
                            maps:put(Dest, 1, Acc2)
                    end
                end,
                Acc,
                Dests
            )
        end,
        InDegree,
        maps:to_list(Graph)
    ),
    ZeroDegreeNodes = lists:filter(
        fun(Node) ->
            maps:get(Node, InDegreeWithEdges, 0) == 0
        end,
        lists:seq(0, NumCourses - 1)
    ),
    {InDegreeWithEdges, ZeroDegreeNodes}.

do_topological_sort(_Graph, _InDegree, [], Acc, 0) ->
    lists:reverse(Acc);
do_topological_sort(_Graph, _InDegree, [], _Acc, _NumCourses) ->
    [];
do_topological_sort(Graph, InDegree, [Node | Rest], Acc, NumCourses) ->
    NewAcc = [Node | Acc],
    case maps:is_key(Node, Graph) of
        true ->
            Dests = maps:get(Node, Graph),
            {NewInDegree, NewZeroDegreeNodes} = lists:foldl(
                fun(Dest, {AccInDegree, AccZeroDegreeNodes}) ->
                    NewDegree = maps:get(Dest, AccInDegree) - 1,
                    NewInDegree2 = maps:update(Dest, NewDegree, AccInDegree),
                    case NewDegree == 0 of
                        true ->
                            {NewInDegree2, [Dest | AccZeroDegreeNodes]};
                        false ->
                            {NewInDegree2, AccZeroDegreeNodes}
                    end
                end,
                {InDegree, []},
                Dests
            ),
            do_topological_sort(Graph, NewInDegree, Rest ++ NewZeroDegreeNodes, NewAcc, NumCourses - 1);
        false ->
            do_topological_sort(Graph, InDegree, Rest, NewAcc, NumCourses - 1)
    end.