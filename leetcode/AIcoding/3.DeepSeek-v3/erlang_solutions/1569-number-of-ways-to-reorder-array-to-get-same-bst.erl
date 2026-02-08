-module(solution).
-export([num_of_ways/1]).

comb(N, K) ->
    if
        K > N -> 0;
        K == 0 -> 1;
        K > N - K -> comb(N, N - K);
        true ->
            Res = 1,
            comb(N, K, Res)
    end.

comb(_, 0, Res) -> Res;
comb(N, K, Res) ->
    comb(N - 1, K - 1, Res * N div K).

num_of_ways(Nums) ->
    case Nums of
        [] -> 0;
        [Root | Rest] ->
            {Left, Right} = lists:partition(fun(X) -> X < Root end, Rest),
            L = length(Left),
            R = length(Right),
            C = comb(L + R, L),
            (C * (num_of_ways(Left) + 1) rem 1000000007 * (num_of_ways(Right) + 1) rem 1000000007 - 1) rem 1000000007
    end.