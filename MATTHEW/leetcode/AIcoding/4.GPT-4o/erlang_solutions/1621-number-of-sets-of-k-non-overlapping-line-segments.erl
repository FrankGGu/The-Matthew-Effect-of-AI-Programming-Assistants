-module(solution).
-export([number_of_sets/3]).

number_of_sets(N, L, K) ->
    dp(0, K, N, L, []).

dp(_, 0, _, _, _) -> 1;
dp(_, K, 0, _, _) -> 0;
dp(Start, K, Rem, L, Used) ->
    lists:sum(
        [dp(Next, K - 1, Rem - Length, L, [Length | Used]) ||
         Length <- lists:seq(1, L),
         Next = Start + Length,
         Next =< Rem]
    ) + dp(Start + 1, K, Rem, L, Used).