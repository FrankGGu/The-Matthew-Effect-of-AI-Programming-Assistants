-module(solution).
-export([minimum_seconds/1]).

minimum_seconds(Nums) ->
    N = length(Nums),
    RawIndexMap = build_index_map(Nums),
    SortedIndexMap = maps:map(fun(_K, V) -> lists:reverse(V) end, RawIndexMap),

    lists:foldl(fun({_Value, Indices}, MinSoFar) ->
                        MaxGapForValue = calculate_max_gap(Indices, N),
                        SecondsForValue = MaxGapForValue div 2,
                        min(MinSoFar, SecondsForValue)
                end, N, maps:to_list(SortedIndexMap)).

build_index_map(Nums) ->
    lists:foldl(fun({Num, Index}, AccMap) ->
                        maps:update_with(Num, fun(L) -> [Index | L] end, [Index], AccMap)
                end, maps:new(), lists:zip(Nums, lists:seq(0, length(Nums)-1))).

calculate_max_gap(Indices, N) ->
    case length(Indices) of
        1 ->
            N;
        _ ->
            Gaps = lists:zipwith(fun(P1, P2) -> P2 - P1 end,
                                 lists:droplast(Indices),
                                 lists:drop(1, Indices)),
            CircularGap = N - lists:last(Indices) + lists:nth(1, Indices),
            lists:max([CircularGap | Gaps])
    end.