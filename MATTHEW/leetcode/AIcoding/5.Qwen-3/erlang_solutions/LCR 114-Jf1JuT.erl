-module(mars_dictionary).
-export([alien_order/1]).

alien_order(WordList) ->
    case WordList of
        [] -> "";
        _ ->
            Graph = build_graph(WordList),
            InDegree = build_indegree(Graph),
            Queue = find_start_nodes(InDegree),
            Result = topological_sort(Graph, InDegree, Queue, []),
            case length(Result) == length(InDegree) of
                true -> lists:flatten(Result);
                false -> ""
            end
    end.

build_graph([]) -> #{}; 
build_graph([_ | _] = Words) ->
    Graph = maps:new(),
    lists:foldl(fun(Word, Acc) ->
        lists:foldl(fun({A, B}, G) ->
            case maps:is_key(A, G) of
                true -> maps:update(A, [B | maps:get(A, G)], G);
                false -> maps:put(A, [B], G)
            end
        end, Acc, get_edges(Word, Words))
    end, Graph, Words).

get_edges(_, []) -> [];
get_edges(Word, [NextWord | Rest]) ->
    case compare_words(Word, NextWord) of
        {equal, _} -> get_edges(Word, Rest);
        {diff, A, B} -> [{A, B} | get_edges(Word, Rest)];
        {stop, _} -> []
    end.

compare_words([], []) -> {equal, []};
compare_words([], _) -> {stop, []};
compare_words(_, []) -> {stop, []};
compare_words([A | T1], [B | T2]) ->
    if
        A == B -> compare_words(T1, T2);
        true -> {diff, A, B}
    end.

build_indegree(Graph) ->
    maps:fold(fun(_K, V, Acc) ->
        lists:foldl(fun(Node, A) -> maps:update(Node, maps:get(Node, A, 0) + 1, A) end, Acc, V)
    end, maps:new(), Graph).

find_start_nodes(InDegree) ->
    maps:fold(fun(K, V, Acc) ->
        if V == 0 -> [K | Acc]; true -> Acc end
    end, [], InDegree).

topological_sort(_, _, [], Result) -> Result;
topological_sort(Graph, InDegree, [Node | Queue], Result) ->
    NewResult = [Node | Result],
    Neighbors = maps:get(Node, Graph, []),
    NewInDegree = lists:foldl(fun(Neighbor, ID) ->
        maps:update(Neighbor, maps:get(Neighbor, ID) - 1, ID)
    end, InDegree, Neighbors),
    NewQueue = lists:foldl(fun(Neighbor, Q) ->
        case maps:get(Neighbor, NewInDegree, 0) of
            0 -> [Neighbor | Q];
            _ -> Q
        end
    end, Queue, Neighbors),
    topological_sort(Graph, NewInDegree, NewQueue, NewResult).