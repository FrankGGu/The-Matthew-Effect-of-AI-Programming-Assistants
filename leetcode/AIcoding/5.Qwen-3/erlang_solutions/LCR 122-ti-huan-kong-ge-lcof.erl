-module(solution).
-export([encrypt/1]).

encrypt(Path) ->
    encrypt(Path, 0, []).

encrypt([], _, Result) ->
    lists:reverse(Result);
encrypt([H | T], Level, Result) when H == $/ ->
    encrypt(T, Level + 1, [Level | Result]);
encrypt([H | T], Level, Result) ->
    encrypt(T, Level, [H | Result]).