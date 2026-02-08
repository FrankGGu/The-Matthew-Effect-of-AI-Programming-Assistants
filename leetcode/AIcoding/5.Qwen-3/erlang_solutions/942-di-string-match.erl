-module(di_string_match).
-export([diStringMatch/1]).

diStringMatch(S) ->
    N = length(S),
    Low = 0,
    High = N,
    diStringMatch(S, Low, High, []).

diStringMatch([], _, _, Result) ->
    lists:reverse(Result);
diStringMatch([$D | T], Low, High, Result) ->
    diStringMatch(T, Low + 1, High, [Low | Result]);
diStringMatch([$I | T], Low, High, Result) ->
    diStringMatch(T, Low, High - 1, [High | Result]).