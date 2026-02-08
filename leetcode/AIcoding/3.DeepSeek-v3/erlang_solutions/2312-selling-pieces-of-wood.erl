-module(solution).
-export([selling_wood/2]).

selling_wood(M, N, Prices) ->
    DP = array:new([{size, M + 1}, {default, array:new([{size, N + 1}, {default, 0}])}]),
    lists:foreach(fun({H, W, P}) ->
                      H1 = min(H, M),
                      W1 = min(W, N),
                      Old = array:get(H1, DP),
                      New = array:set(W1, max(array:get(W1, Old), P), Old),
                      array:set(H1, New, DP)
                  end, Prices),
    lists:foldl(fun(I, AccDP) ->
                    RowI = array:get(I, AccDP),
                    lists:foldl(fun(J, AccRow) ->
                                    Max = lists:max([
                                        array:get(J, AccRow),
                                        lists:max([array:get(K, AccRow) + array:get(J - K, AccRow) || K <- lists:seq(1, J div 2)]]),
                                        lists:max([array:get(J, array:get(K, AccDP)) + array:get(J, array:get(I - K, AccDP)) || K <- lists:seq(1, I div 2)]])
                                    ]),
                                    array:set(J, Max, AccRow)
                                end, RowI, lists:seq(1, N)),
                    array:set(I, NewRow, AccDP)
                end, DP, lists:seq(1, M)),
    array:get(N, array:get(M, DP)).