-module(bowling_game).
-export([calculate_score/1]).

calculate_score(Games) ->
    calculate_score(Games, 0, 0).

calculate_score([], Player1Score, Player2Score) ->
    case Player1Score > Player2Score of
        true -> 1;
        false -> case Player2Score > Player1Score of
            true -> 2;
            false -> 0
        end
    end;
calculate_score([{P1, P2} | Rest], Player1Score, Player2Score) ->
    case {P1, P2} of
        {X, Y} when X > Y -> calculate_score(Rest, Player1Score + 1, Player2Score);
        {X, Y} when X < Y -> calculate_score(Rest, Player1Score, Player2Score + 1);
        _ -> calculate_score(Rest, Player1Score, Player2Score)
    end.