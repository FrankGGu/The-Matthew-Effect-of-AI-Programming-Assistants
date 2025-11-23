-module(solution).
-export([buildMatrix/3]).

buildMatrix(K, RowConditions, ColConditions) ->
    RowOrder = topological_sort(K, RowConditions),
    ColOrder = topological_sort(K, ColConditions),

    case {RowOrder, ColOrder} of
        {[], _} -> [];
        {_, []} -> [];
        {RList, CList} ->
            build_final_matrix(K, RList, CList)
    end.

topological_sort(K, Conditions) ->
    Graph0 = maps:new(),
    InDegree0 = maps:new(),

    {Graph, InDegree} = lists:foldl(fun(I, {G, ID}) ->
                                        {maps:put(I, [], G), maps:put(I, 0, ID)}
                                end, {Graph0, InDegree0}, lists:seq(1, K)),

    {FinalGraph, FinalInDegree} = lists:foldl(fun([U, V], {G, ID}) ->
                                                G_new = maps:update(U, fun(L) -> [V|L] end, G),
                                                ID_new = maps:update(V, fun(C) -> C+1 end, ID),
                                                {G_new, ID_new}
                                            end, {Graph, InDegree}, Conditions),

    Queue0 = queue:new(),
    InitialQueue = lists:foldl(fun(I, Q) ->
                                   case maps:get(I, FinalInDegree) of
                                       0 -> queue:in(I, Q);
                                       _ -> Q
                                   end
                               end, Queue0, lists:seq(1, K)),

    {SortedList, _, _} = 
        topological_sort_loop(InitialQueue, FinalGraph, FinalInDegree, [], K),

    case length(SortedList) == K of
        true -> lists:reverse(SortedList);
        false -> []
    end.

topological_sort_loop(Queue, Graph, InDegree, AccSorted, K) ->
    case queue:is_empty(Queue) of
        true -> {AccSorted, InDegree, Queue};
        false ->
            {value, U, Queue1} = queue:out(Queue),
            Neighbors = maps:get(U, Graph),

            {NewInDegree, NewQueue} = lists:foldl(fun(V, {ID, Q}) ->
                                                    ID_new = maps:update(V, fun(C) -> C-1 end, ID),
                                                    case maps:get(V, ID_new) of
                                                        0 -> {ID_new, queue:in(V, Q)};
                                                        _ -> {ID_new, Q}
                                                    end
                                                end, {InDegree, Queue1}, Neighbors),
            topological_sort_loop(NewQueue, Graph, NewInDegree, [U | AccSorted], K)
    end.

build_final_matrix(K, RowOrder, ColOrder) ->
    RowPosMap = lists:foldl(fun({Num, Idx}, Map) -> maps:put(Num, Idx, Map) end, maps:new(), lists:zip(RowOrder, lists:seq(0, K-1))),
    ColPosMap = lists:foldl(fun({Num, Idx}, Map) -> maps:put(Num, Idx, Map) end, maps:new(), lists:zip(ColOrder, lists:seq(0, K-1))),

    RowToNumMap = lists:foldl(fun(Num, Map) -> maps:put(maps:get(Num, RowPosMap), Num, Map) end, maps:new(), lists:seq(1, K)),

    Matrix = lists:foldl(fun(R, AccMatrix) ->
                             NumAtR = maps:get(R, RowToNumMap),
                             ColIdx = maps:get(NumAtR, ColPosMap),

                             Row = lists:duplicate(K, 0),
                             Row_with_Num = lists:replace_nth(ColIdx + 1, NumAtR, Row),

                             [Row_with_Num | AccMatrix]
                         end, [], lists:seq(0, K-1)),

    lists:reverse(Matrix).