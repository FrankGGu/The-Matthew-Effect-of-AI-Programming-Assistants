-module(k_sum_pairs).
-export([maxOperations/2]).

maxOperations(Nums, K) ->
    maxOperations(Nums, K, #{}, 0).

maxOperations([], _, _, Count) ->
    Count;
maxOperations([H|T], K, Freq, Count) ->
    Needed = K - H,
    case maps:get(Needed, Freq, 0) of
        0 ->
            NewFreq = maps:update_with(H, fun(X) -> X + 1 end, 1, Freq),
            maxOperations(T, K, NewFreq, Count);
        1 ->
            NewFreq = maps:remove(Needed, Freq),
            maxOperations(T, K, NewFreq, Count + 1);
        N ->
            NewFreq = maps:update(Needed, N - 1, Freq),
            maxOperations(T, K, NewFreq, Count + 1)
    end.