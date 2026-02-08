-module(solution).
-export([minimum_cost/1]).

minimum_cost(Cuts) ->
    SortedCuts = lists:sort(Cuts),
    N = length(SortedCuts),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    minimum_cost(SortedCuts, 0, N - 1, DP).

minimum_cost(Cuts, I, J, DP) ->
    case I >= J of
        true -> 0;
        false ->
            case array:get(I, array:get(J, DP)) of
                0 ->
                    MinCost = lists:min(
                        lists:map(
                            fun(K) ->
                                (lists:nth(J + 1, Cuts) - lists:nth(I + 1, Cuts)) +
                                minimum_cost(Cuts, I, K - 1, DP) +
                                minimum_cost(Cuts, K, J, DP)
                            end,
                            lists:seq(I + 1, J)
                        )
                    ),
                    NewRow = array:set(J, MinCost, array:get(I, DP)),
                    NewDP = array:set(I, NewRow, DP),
                    array:set(I, array:set(J, MinCost, array:get(I, NewDP)), NewDP),
                    MinCost;
                Cached -> Cached
            end
    end.