-module(last_day_to_cross).
-export([latestDayToCross/2]).

latestDayToCross(Row, Col, Cells) ->
    L = length(Cells),
    latestDayToCross(Row, Col, Cells, 1, L).

latestDayToCross(Row, Col, Cells, Low, High) ->
    if Low > High ->
        High;
    true ->
        Mid = (Low + High) div 2,
        if canCross(Row, Col, Cells, Mid) ->
            latestDayToCross(Row, Col, Cells, Mid + 1, High);
        true ->
            latestDayToCross(Row, Col, Cells, Low, Mid - 1)
    end.

canCross(Row, Col, Cells, Day) ->
    Grid = createGrid(Row, Col, Cells, Day),
    Visited = lists:foldl(fun(_, Acc) -> Acc), [], lists:seq(1, Col)),
    hasPath(Grid, Row, Col, Visited).

createGrid(Row, Col, Cells, Day) ->
    Grid = lists:duplicate(Row, lists:duplicate(Col, 0)),
    lists:foldl(
        fun({R, C}, Acc) ->
            lists:nth(R, Acc) ! lists:setval(C, 1, lists:nth(R, Acc)),
            Acc
        end,
        Grid,
        lists:sublist(Cells, 1, Day)
    ).

hasPath(Grid, Row, Col, Visited) ->
    Queue = lists:seq(1, Col),
    hasPath(Grid, Row, Col, Queue, lists:duplicate(Row * Col, false)).

hasPath(Grid, Row, Col, [], _) ->
    false;
hasPath(Grid, Row, Col, [ColIdx | Rest], Visited) ->
    if isOutOfBounds(1, ColIdx, Row, Col) ->
        hasPath(Grid, Row, Col, Rest, Visited);
    true ->
        if isBlocked(Grid, 1, ColIdx) ->
            hasPath(Grid, Row, Col, Rest, Visited);
        true ->
            if isVisited(Visited, 1, ColIdx, Col) ->
                hasPath(Grid, Row, Col, Rest, Visited);
            true ->
                NewVisited = setVisited(Visited, 1, ColIdx, Col),
                if 1 == Row ->
                    true;
                true ->
                    NewQueue = getNeighbors(1, ColIdx, Row, Col) ++ Rest,
                    hasPathHelper(Grid, Row, Col, NewQueue, NewVisited)
            end
        end
    end.

hasPathHelper(Grid, Row, Col, [], Visited) ->
    false;
hasPathHelper(Grid, Row, Col, [RC | Rest], Visited) ->
    {R, C} = RC,
    if isOutOfBounds(R, C, Row, Col) ->
        hasPathHelper(Grid, Row, Col, Rest, Visited);
    true ->
        if isBlocked(Grid, R, C) ->
            hasPathHelper(Grid, Row, Col, Rest, Visited);
        true ->
            if isVisited(Visited, R, C, Col) ->
                hasPathHelper(Grid, Row, Col, Rest, Visited);
            true ->
                NewVisited = setVisited(Visited, R, C, Col),
                if R == Row ->
                    true;
                true ->
                    NewQueue = getNeighbors(R, C, Row, Col) ++ Rest,
                    hasPathHelper(Grid, Row, Col, NewQueue, NewVisited)
            end
        end
    end.

getNeighbors(R, C, Row, Col) ->
    Neighbors = [
        {R - 1, C},
        {R + 1, C},
        {R, C - 1},
        {R, C + 1}
    ],
    lists:filter(
        fun({Nr, Nc}) ->
            not isOutOfBounds(Nr, Nc, Row, Col)
        end,
        Neighbors
    ).

isOutOfBounds(R, C, Row, Col) ->
    R < 1 or R > Row or C < 1 or C > Col.

isBlocked(Grid, R, C) ->
    lists:nth(C, lists:nth(R, Grid)) == 1.

isVisited(Visited, R, C, Col) ->
    lists:nth((R - 1) * Col + C, Visited).

setVisited(Visited, R, C, Col) ->
    lists:setval((R - 1) * Col + C, true, Visited).