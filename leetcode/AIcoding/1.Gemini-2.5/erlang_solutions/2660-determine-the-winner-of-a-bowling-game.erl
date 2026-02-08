-module(solution).
-export([game_winner/2]).

game_winner(Player1, Player2) ->
    Score1 = calculate_score(Player1),
    Score2 = calculate_score(Player2),
    if
        Score1 > Score2 -> 1;
        Score2 > Score1 -> 2;
        true -> 0
    end.

calculate_score(PlayerList) ->
    calculate_score_helper(PlayerList, 0, -1, -1).

calculate_score_helper([], AccScore, _PrevPin, _PrevPrevPin) ->
    AccScore;
calculate_score_helper([CurrentPin | Rest], AccScore, PrevPin, PrevPrevPin) ->
    NewAccScore = AccScore + CurrentPin,
    Bonus1 = if
                 PrevPin == 10 -> CurrentPin;
                 true -> 0
             end,
    Bonus2 = if
                 PrevPrevPin + PrevPin == 10 -> CurrentPin;
                 true -> 0
             end,
    calculate_score_helper(Rest, NewAccScore + Bonus1 + Bonus2, CurrentPin, PrevPin).