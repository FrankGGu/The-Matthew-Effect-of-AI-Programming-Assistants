-module(solution).
-export([min_flips/1]).

min_flips(BinaryString) ->
    Bits = string:to_integer(BinaryString, 2),
    count_flips(Bits, 0, 0).

count_flips(0, Flips, _) -> Flips;
count_flips(Bits, Flips, LastBit) ->
    CurrentBit = Bits band 1,
    NewFlips = if
        CurrentBit /= LastBit -> Flips + 1;
        true -> Flips
    end,
    count_flips(Bits bsr 1, NewFlips, CurrentBit).