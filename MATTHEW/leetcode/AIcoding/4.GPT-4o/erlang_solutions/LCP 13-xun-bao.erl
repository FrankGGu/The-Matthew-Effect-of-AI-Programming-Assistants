-module(sol).
-export([treasure/1]).

treasure(M) ->
    {Rows, Cols} = lists:foldl(fun (Row, {R, C}) -> {R + 1, max(C, length(Row))} end, {0, 0}, M),
    find_treasure(M, Rows, Cols, 0, 0, 0).

find_treasure(_, 0, _, Max, Cols, _) when Max > Cols -> Max;
find_treasure([], R, C, Max, Cols, _) -> Max;
find_treasure([Row | T], R, C, Max, Cols, CurrentRow) ->
    Max1 = lists:max([Max, lists:nth(CurrentRow + 1, Row)]),
    find_treasure(T, R - 1, C, Max1, Cols, CurrentRow + 1).