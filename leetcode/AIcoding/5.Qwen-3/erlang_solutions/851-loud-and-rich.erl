-module(loud_and_rich).
-export([loudAndRich/1]).

loudAndRich(Relations) ->
    Graph = build_graph(Relations),
    Map = maps:from_list([{User, {0, []}} || User <- all_users(Graph)]),
    TopoSort = topological_sort(Graph),
    lists:map(fun(User) -> get_answer(User, Graph, Map) end, TopoSort).

build_graph(Relations) ->
    Graph = gb_sets:empty(),
    lists:foldl(fun({A, B}, Acc) ->
        gb_sets:add(A, gb_sets:add(B, Acc))
    end, Graph, Relations).

all_users(Graph) ->
    gb_sets:to_list(Graph).

topological_sort(Graph) ->
    InDegree = maps:from_list([{User, 0} || User <- gb_sets:to_list(Graph)]),
    Adj = maps:from_list([{User, []} || User <- gb_sets:to_list(Graph)]),
    lists:foreach(fun({A, B}) ->
        maps:update(B, [A | maps:get(B, Adj)], Adj),
        maps:update(A, maps:get(A, InDegree) + 1, InDegree)
    end, relations_from_graph(Graph)),
    Queue = [User || {User, Degree} <- maps:to_list(InDegree), Degree == 0],
    topological_sort_helper(Queue, InDegree, Adj, []).

topological_sort_helper([], _, _, Result) ->
    lists:reverse(Result);
topological_sort_helper([User | Rest], InDegree, Adj, Result) ->
    NewResult = [User | Result],
    lists:foreach(fun(Next) ->
        maps:update(Next, maps:get(Next, InDegree) - 1, InDegree),
        if maps:get(Next, InDegree) == 0 ->
            topological_sort_helper([Next | Rest], InDegree, Adj, NewResult);
        true ->
            ok
        end
    end, maps:get(User, Adj)),
    topological_sort_helper(Rest, InDegree, Adj, NewResult).

relations_from_graph(Graph) ->
    Users = gb_sets:to_list(Graph),
    lists:foldl(fun(User, Acc) ->
        lists:foldl(fun(Other, Acc2) ->
            if User < Other ->
                [{User, Other} | Acc2];
            true ->
                Acc2
            end
        end, Acc, Users)
    end, [], Users).

get_answer(User, Graph, Map) ->
    case maps:get(User, Map) of
        {0, []} ->
            lists:foldl(fun(Other, Acc) ->
                case maps:get(Other, Map) of
                    {0, []} -> Acc;
                    {Count, _} -> if Count > maps:get(User, Map, {0, []}) -> Acc; true -> Acc end
                end
            end, User, neighbors(User, Graph));
        {Count, Others} ->
            lists:foldl(fun(Other, Acc) ->
                case maps:get(Other, Map) of
                    {0, []} -> Acc;
                    {OtherCount, _} -> if OtherCount > Count -> Acc; true -> Acc end
                end
            end, User, Others)
    end.

neighbors(User, Graph) ->
    Users = gb_sets:to_list(Graph),
    [Other || Other <- Users, is_related(User, Other, Graph)].

is_related(A, B, Graph) ->
    lists:member(A, gb_sets:to_list(gb_sets:search(B, Graph))).