-module(solution).
-export([minMoves/1]).

minMoves(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Player, Box, Target} = findPositions(Grid, Rows, Cols),
    BFS([{Player, Box, 0}], Grid, Rows, Cols, Player, Box, Target).

findPositions(Grid, Rows, Cols) ->
    lists:foldl(fun(Row, {P, B, T}) ->
        lists:foldl(fun({Cell, Col}, {P, B, T}) ->
            case Cell of
                $S -> { {Row, Col}, B, T };
                $B -> { P, {Row, Col}, T };
                $T -> { P, B, {Row, Col} };
                _ -> { P, B, T }
            end
        end, {P, B, T}, lists:zip(Grid, lists:seq(0, Cols-1)))
    end, {none, none, none}, lists:seq(0, Rows-1)).

BFS(Queue, Grid, Rows, Cols, Player, Box, Target) ->
    case Queue of
        [] -> -1;
        [{Pos, BoxPos, Moves} | Rest] ->
            if Pos == BoxPos andalso BoxPos == Target -> Moves;
               true ->
                    NewQueue = generateNextStates(Pos, BoxPos, Moves+1, Grid, Rows, Cols),
                    BFS(NewQueue ++ Rest, Grid, Rows, Cols, Player, Box, Target)
            end
    end.

generateNextStates(Pos, BoxPos, Moves, Grid, Rows, Cols) ->
    Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
    lists:foldl(fun(Dir, Acc) ->
        NewPos = {Pos#tuple{0} + Dir#tuple{0}, Pos#tuple{1} + Dir#tuple{1}},
        if NewPos#tuple{0} >= 0, NewPos#tuple{0} < Rows, NewPos#tuple{1} >= 0, NewPos#tuple{1} < Cols ->
            Cell = getCell(Grid, NewPos),
            if Cell == $.
                or Cell == $T ->
                    [ {NewPos, BoxPos, Moves} | Acc ];
               Cell == $B ->
                    BoxDir = {BoxPos#tuple{0} + Dir#tuple{0}, BoxPos#tuple{1} + Dir#tuple{1}},
                    if BoxDir#tuple{0} >= 0, BoxDir#tuple{0} < Rows, BoxDir#tuple{1} >= 0, BoxDir#tuple{1} < Cols ->
                        BoxCell = getCell(Grid, BoxDir),
                        if BoxCell == $. ->
                            [ {NewPos, BoxDir, Moves} | Acc ];
                           true -> Acc
                        end;
                   true -> Acc
                end;
              true -> Acc
            end
        end
    end, [], Directions).

getCell(Grid, {R, C}) ->
    lists:nth(R+1, Grid) -- [$\n] -- [lists:nth(C+1, lists:nth(R+1, Grid))].

tuple(X, Y) -> {X, Y}.