-module(scramble_string).
-export([is_scramble/2]).

is_scramble(S1, S2) ->
    is_scramble(S1, S2, 0, length(S1), 0, length(S2)).

is_scramble(S1, S2, I1, L1, I2, L2) when L1 =/= L2 -> false;
is_scramble(S1, S2, I1, L1, I2, L2) when L1 == 1 -> string:slice(S1, I1, 1) == string:slice(S2, I2, 1);
is_scramble(S1, S2, I1, L1, I2, L2) ->
    case string:slice(S1, I1, L1) == string:slice(S2, I2, L2) of
        true -> true;
        false ->
            lists:foldl(fun(K, Acc) ->
                            if Acc /= false -> Acc;
                               true ->
                                    case is_scramble(S1, S2, I1, K, I2, K) andalso is_scramble(S1, S2, I1+K, L1-K, I2+K, L2-K) of
                                        true -> true;
                                        _ -> is_scramble(S1, S2, I1, K, I2 + (L2 - K), K) andalso is_scramble(S1, S2, I1+K, L1-K, I2, L2-K)
                                    end
                            end
                        end, false, lists:seq(1, L1-1)).