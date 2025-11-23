-module(solution).
-export([num_ways/1]).

num_ways(N) ->
    Mod = 1000000000 + 7,

    A_prev = 6,
    B_prev = 6,

    {Final_A, Final_B} = lists:foldl(
        fun(_RowIdx, {Prev_A, Prev_B}) ->
            Current_A = (3 * Prev_A + 2 * Prev_B) rem Mod,
            Current_B = (2 * Prev_A + 2 * Prev_B) rem Mod,
            {Current_A, Current_B}
        end,
        {A_prev, B_prev},
        lists:seq(2, N)
    ),

    (Final_A + Final_B) rem Mod.