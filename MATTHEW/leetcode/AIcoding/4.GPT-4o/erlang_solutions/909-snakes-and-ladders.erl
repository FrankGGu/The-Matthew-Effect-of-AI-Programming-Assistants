-module(snakes_and_ladders).
-export([snakes_and_ladders/1]).

snakes_and_ladders(Board) ->
    N = length(Board),
    Start = {1, 0},
    Target = N * N,
    bfs([{Start}], #{Start => 0}, Target, Board).

bfs([], _, _, _) -> -1;
bfs([{Pos, Steps} | Rest], Visited, Target, Board) ->
    case Pos of
        Target -> Steps;
        _ ->
            NewVisited = maps:put(Pos, Steps, Visited),
            NextSteps = lists:map(fun roll/1, lists:seq(1, 6)),
            NewPositions = lists:flatmap(fun {Roll, NewPos} ->
                case snakes_and_ladders_move(Pos + Roll, Board) of
                    NewPos when NewPos =< Target, not maps:is_key(NewPos, NewVisited) ->
                        [{NewPos, Steps + 1}];
                    _ -> []
                end
            end, lists:zip(lists:seq(1, 6), NextSteps)),
            bfs(Rest ++ NewPositions, NewVisited, Target, Board)
    end.

snakes_and_ladders_move(Pos, Board) ->
    Row = (Pos - 1) div length(Board) + 1,
    Col = (Pos - 1) rem length(Board) + 1,
    if
        Row rem 2 =:= 0 -> Ind = length(Board) - Col + 1;
        true -> Col
    end,
    case lists:nth(Row, Board) of
        L when L =:= -1 -> Pos;
        L -> L
    end.