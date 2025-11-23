-module(minimize_hamming_distance).
-export([minimizeHammingDistance/3]).

minimizeHammingDistance(Nums1, Nums2, AllowedSwaps) ->
    N = length(Nums1),
    UF = uf_init(N),

    lists:foreach(fun([U, V]) -> uf_union(UF, U, V) end, AllowedSwaps),

    Components = get_components(UF, N),

    lists:foldl(
        fun(Component, Acc) ->
            Nums1Component = [Nums1!!I || I <- Component],
            Nums2Component = [Nums2!!I || I <- Component],

            Acc + component_hamming_distance(Nums1Component, Nums2Component)
        end,
        0,
        Components
    ).

component_hamming_distance(Nums1Component, Nums2Component) ->
    Map1 = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums1Component),
    Map2 = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums2Component),

    HammingDistance = lists:foldl(
        fun({Key, Count1}, Acc) ->
            Count2 = maps:get(Key, Map2, 0),
            Acc + abs(Count1 - Count2)
        end,
        0,
        maps:to_list(Map1)
    ) div 2.

get_components(UF, N) ->
    lists:foldl(
        fun(I, Acc) ->
            Root = uf_find(UF, I),
            case lists:keyfind(Root, 1, Acc) of
                false ->
                    [{Root, [I]} | Acc];
                {Root, List} ->
                    lists:keyreplace(Root, 1, Acc, {Root, [I | List]})
            end
        end,
        [],
        lists:seq(0, N - 1)
    ).

uf_init(N) ->
    lists:map(fun(I) -> {I, I, 0} end, lists:seq(0, N - 1)).

uf_find(UF, I) ->
    {_, Root, _} = uf_find_helper(UF, I),
    Root.

uf_find_helper(UF, I) ->
    {I, Root, Rank} = lists:nth(I + 1, UF),
    if I == Root then
        {I, Root, Rank}
    else
        {_, NewRoot, _} = uf_find_helper(UF, UF!!(Root + 1) -1),
        NewUF = lists:replace(I + 1, {I, NewRoot, Rank}, UF),
        {I, NewRoot, Rank}
    end.

uf_union(UF, X, Y) ->
    RootX = uf_find(UF, X),
    RootY = uf_find(UF, Y),

    if RootX == RootY then
        UF
    else
        {_, _, RankX} = lists:nth(RootX + 1, UF),
        {_, _, RankY} = lists:nth(RootY + 1, UF),

        if RankX < RankY then
            NewUF = lists:replace(RootX + 1, {RootX, RootY, RankX}, UF),
            NewUF
        elseif RankX > RankY then
            NewUF = lists:replace(RootY + 1, {RootY, RootX, RankY}, UF),
            NewUF
        else
            NewUF1 = lists:replace(RootY + 1, {RootY, RootX, RankY}, UF),
            NewUF = lists:replace(RootX + 1, {RootX, RootX, RankX + 1}, NewUF1),
            NewUF
        end
    end.