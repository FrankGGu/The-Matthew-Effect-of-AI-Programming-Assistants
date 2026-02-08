-module(kth_factor_of_n).
-export([kthFactor/2]).

kthFactor(N, K) ->
    Factors = factors(N),
    lists:nth(K, Factors).

factors(N) ->
    factors(N, 1, []).

factors(_, I, Acc) when I > N ->
    lists:reverse(Acc);
factors(N, I, Acc) ->
    case N rem I of
        0 ->
            factors(N, I + 1, [I | Acc]);
        _ ->
            factors(N, I + 1, Acc)
    end.