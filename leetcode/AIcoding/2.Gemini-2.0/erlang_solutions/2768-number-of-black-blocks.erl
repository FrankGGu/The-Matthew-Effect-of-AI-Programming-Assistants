-module(number_of_black_blocks).
-export([solve/1]).

solve(N) ->
    Rows = N#height,
    Cols = N#width,
    Points = N#points,

    Count = maps:new(),

    lists:foreach(fun(Point) ->
        X = Point#x,
        Y = Point#y,

        [
            update_count(Count, X, Y, Rows, Cols),
            update_count(Count, X - 1, Y, Rows, Cols),
            update_count(Count, X, Y - 1, Rows, Cols),
            update_count(Count, X - 1, Y - 1, Rows, Cols)
        ]
    end, Points),

    Result = [maps:get(I, Count, 0) || I <- lists:seq(0, 4)],

    TotalSquares = (Rows - 1) * (Cols - 1),
    Uncovered = TotalSquares - lists:sum(Result),
    [Uncovered | Result].

update_count(Count, X, Y, Rows, Cols) ->
    if X >= 0 andalso X < Rows - 1 andalso Y >= 0 andalso Y < Cols - 1 then
        Key = count_black_blocks(X, Y, Rows, Cols, N#points),
        maps:update_with(Key, fun(Value) -> Value + 1 end, 1, Count)
    else
        ok
    end.

count_black_blocks(X, Y, Rows, Cols, Points) ->
    Count = lists:sum([
        if lists:member({X1, Y1}, [{X, Y}, {X+1, Y}, {X, Y+1}, {X+1, Y+1}]) then
            1
        else
            0
        end
        || Point <- Points,
           X1 = Point#x,
           Y1 = Point#y
    ]),
    Count.