-module(dota2_senate).
-export([predict_winner/1]).

predict_winner(Senate) ->
    R = lists:seq(0, length(Senate) - 1),
    B = lists:seq(0, length(Senate) - 1),
    predict_winner(Senate, R, B).

predict_winner(_, [], B) -> 
    if length(B) > 0 -> "Radiant"; true -> "Dire" end;
predict_winner(_, R, []) -> 
    if length(R) > 0 -> "Dire"; true -> "Radiant" end;
predict_winner(Senate, [RHead | RTail], [BHead | BTail]) ->
    case lists:nth(RHead + 1, Senate) of
        $R ->
            case lists:nth(BHead + 1, Senate) of
                $D ->
                    predict_winner(Senate, RTail ++ [RHead], BTail);
                _ ->
                    predict_winner(Senate, RTail ++ [RHead], BTail)
            end;
        _ ->
            case lists:nth(BHead + 1, Senate) of
                $D ->
                    predict_winner(Senate, RTail, BTail ++ [BHead]);
                _ ->
                    predict_winner(Senate, RTail, BTail ++ [BHead])
            end
    end.