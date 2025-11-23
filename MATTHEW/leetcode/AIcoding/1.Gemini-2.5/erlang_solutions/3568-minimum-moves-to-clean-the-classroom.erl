-module(solution).
-export([min_moves/2]).

min_moves(S, K) ->
    min_moves_recursive(S, K, 0, -1, 0).

min_moves_recursive([], _K, _CurrentIndex, _LastCleanedUntil, Moves) ->
    Moves;
min_moves_recursive([Char | Rest], K, CurrentIndex, LastCleanedUntil, Moves) ->
    if CurrentIndex =< LastCleanedUntil ->
        min_moves_recursive(Rest, K, CurrentIndex + 1, LastCleanedUntil, Moves);
    else
        if Char == $0 ->
            NewMoves = Moves + 1,
            NewLastCleanedUntil = CurrentIndex + K - 1,
            min_moves_recursive(Rest, K, CurrentIndex + 1, NewLastCleanedUntil, NewMoves);
        else
            min_moves_recursive(Rest, K, CurrentIndex + 1, LastCleanedUntil, Moves)
        end
    end.