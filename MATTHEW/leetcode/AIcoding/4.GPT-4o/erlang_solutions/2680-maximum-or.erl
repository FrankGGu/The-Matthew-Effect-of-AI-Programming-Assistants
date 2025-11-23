-module(solution).
-export([maximum_or/1]).

maximum_or(Numbers) ->
    MaximumOR(Numbers, 0, 0).

MaximumOR([], CurrentMax, Result) ->
    Result;
MaximumOR([H | T], CurrentMax, Result) ->
    NewMax = bor(CurrentMax, H),
    MaximumOR(T, NewMax, max(Result, NewMax)).