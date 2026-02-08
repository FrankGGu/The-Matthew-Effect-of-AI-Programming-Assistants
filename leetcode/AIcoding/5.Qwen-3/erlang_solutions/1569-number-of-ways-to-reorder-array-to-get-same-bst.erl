-module(solution).
-export([num_ways/1]).

num_ways([]) -> 0;
num_ways([H|T]) ->
    Left = [X || X <- T, X < H],
    Right = [X || X <- T, X > H],
    N = length(T),
    C = comb(N, length(Left)),
    LeftWays = num_ways(Left),
    RightWays = num_ways(Right),
    (C * LeftWays * RightWays) rem 1000000007.

comb(N, K) when K == 0 -> 1;
comb(N, K) when K == N -> 1;
comb(N, K) -> 
    mod_pow(fact(N), mod_pow(fact(K) * fact(N - K), 1000000005, 1000000007), 1000000007).

fact(N) when N == 0 -> 1;
fact(N) -> N * fact(N - 1).

mod_pow(A, B, Mod) when B == 0 -> 1;
mod_pow(A, B, Mod) when B rem 2 == 0 ->
    mod_pow((A * A) rem Mod, B div 2, Mod);
mod_pow(A, B, Mod) ->
    (A * mod_pow(A, B - 1, Mod)) rem Mod.