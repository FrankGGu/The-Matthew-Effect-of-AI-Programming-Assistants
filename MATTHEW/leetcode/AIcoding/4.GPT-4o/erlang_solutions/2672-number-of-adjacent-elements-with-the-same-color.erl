-module(solution).
-export([count_adjacent/1]).

count_adjacent(Colors) ->
    count_adjacent(Colors, 0).

count_adjacent([], Count) ->
    Count;
count_adjacent([_], Count) ->
    Count;
count_adjacent([H, H | T], Count) ->
    count_adjacent([H | T], Count + 1);
count_adjacent([H1, H2 | T], Count) ->
    count_adjacent([H2 | T], Count).