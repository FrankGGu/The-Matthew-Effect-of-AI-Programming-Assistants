-module(solution).
-export([flip_chess/1]).

flip_chess(Board) ->
    flip_chess(Board, 0, 0).

flip_chess([], Max) ->
    Max;
flip_chess([Row | Rest], Max) ->
    NewMax = lists:max([Max | lists:map(fun(X) -> count_flips(X) end, Row)]),
    flip_chess(Rest, NewMax).

count_flips(Black) ->
    count_flips(Black, 0).

count_flips([], Count) ->
    Count;
count_flips([H | T], Count) when H == '#' ->
    count_flips(T, Count + 1);
count_flips([_ | T], Count) ->
    count_flips(T, Count).