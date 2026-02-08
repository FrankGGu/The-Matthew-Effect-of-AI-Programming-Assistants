-module(knight_dialer).
-export([knightDialer/1]).

knightDialer(N) when N >= 1 ->
    Paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
             [4, 5, 6],
             [2, 3, 4, 5, 6, 8],
             [0, 1, 2, 4, 5, 6, 7, 8, 9],
             [0, 1, 3, 4, 5, 6, 7, 8, 9],
             [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
             [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
             [0, 1, 3, 4, 5, 6, 7, 8, 9],
             [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
             [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]],
    Mod = 1000000007,
    lists:foldl(fun(_, Acc) -> next_step(Acc, Paths, Mod) end, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], lists:seq(1, N)).

next_step(Prev, Paths, Mod) ->
    lists:map(fun(Idx) -> lists:sum(lists:map(fun(X) -> lists:nth(X + 1, Prev) end, lists:nth(Idx + 1, Paths))) rem Mod end, lists:seq(0, 9).