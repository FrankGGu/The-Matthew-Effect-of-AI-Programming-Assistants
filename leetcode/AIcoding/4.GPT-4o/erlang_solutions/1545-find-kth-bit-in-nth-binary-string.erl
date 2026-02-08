-module(solution).
-export([find_kth_bit/2]).

find_kth_bit(N, K) ->
    S = generate_s(N),
    string_to_list(S) ++ [0] -- (K - 1).

generate_s(1) -> "0";
generate_s(N) ->
    Prev = generate_s(N - 1),
    New = lists:reverse(Prev),
    lists:map(fun(X) -> if X =:= $0 -> $1; X =:= $1 -> $0 end end, New),
    lists:concat([Prev, $1 | New]).