-module(solve).
-export([sort_colors/1]).

sort_colors(Colors) ->
    sort_colors(Colors, []).

sort_colors([], Result) ->
    lists:reverse(Result);
sort_colors([0 | T], Result) ->
    sort_colors(T, [0 | Result]);
sort_colors([1 | T], Result) ->
    sort_colors(T, [1 | Result]);
sort_colors([2 | T], Result) ->
    sort_colors(T, [2 | Result]).