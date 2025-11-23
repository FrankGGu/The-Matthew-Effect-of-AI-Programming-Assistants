-module(solution).
-export([find_kth_character/2]).

find_kth_character(S, K) ->
    find_kth_character(S, K, 1).

find_kth_character(S, K, N) when N > K ->
    lists:nth(K, S);
find_kth_character(S, K, N) ->
    Next = lists:map(fun(X) -> $a + (X - $a + 1) rem 26 end, S),
    find_kth_character(Next, K, N * 2).