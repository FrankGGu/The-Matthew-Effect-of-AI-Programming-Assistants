-module(minimum_bit_flips).
-export([min_bit_flips/2]).

min_bit_flips(Start, Goal) ->
    min_bit_flips_helper(Start, Goal, 0).

min_bit_flips_helper(0, 0, Count) ->
    Count;
min_bit_flips_helper(Start, Goal, Count) ->
    Bit_Start = Start band 1,
    Bit_Goal = Goal band 1,
    New_Count = if Bit_Start =/= Bit_Goal -> Count + 1; true -> Count end,
    min_bit_flips_helper(Start bsr 1, Goal bsr 1, New_Count).