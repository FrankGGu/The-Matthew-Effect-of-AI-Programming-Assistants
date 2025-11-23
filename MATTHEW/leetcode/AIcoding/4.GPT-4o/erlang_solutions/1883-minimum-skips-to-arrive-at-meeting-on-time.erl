-module(solution).
-export([min_skips/2]).

min_skips(D, T) ->
    min_skips(D, T, 0, 0, []).

min_skips([], _, Skips, Time, _) when Time =< 0 ->
    Skips;
min_skips([H | T], T, Skips, Time, _) ->
    min_skips(T, T - H, Skips, Time + H, [H | []]);
min_skips([H | T], T, Skips, Time, History) ->
    min_skips(T, T - H, Skips + 1, Time + H, History).