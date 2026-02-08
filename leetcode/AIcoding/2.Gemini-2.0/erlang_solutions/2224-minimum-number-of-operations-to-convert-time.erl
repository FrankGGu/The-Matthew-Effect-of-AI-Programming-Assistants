-module(solution).
-export([convert_time/2]).

convert_time(Current, Correct) ->
    [CH, CM] = string:split(Current, ":", all),
    [COH, COM] = string:split(Correct, ":", all),
    CurrentMinutes = (list_to_integer(CH) * 60) + list_to_integer(CM),
    CorrectMinutes = (list_to_integer(COH) * 60) + list_to_integer(COM),
    Diff = CorrectMinutes - CurrentMinutes,
    convert(Diff, 0).

convert(0, Count) ->
    Count;
convert(Diff, Count) when Diff >= 60 ->
    convert(Diff - 60, Count + 1);
convert(Diff, Count) when Diff >= 15 ->
    convert(Diff - 15, Count + 1);
convert(Diff, Count) when Diff >= 5 ->
    convert(Diff - 5, Count + 1);
convert(Diff, Count) ->
    convert(Diff - 1, Count + 1).