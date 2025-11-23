-module(solution).
-export([maximum_score/3]).

maximum_score(S, L, R) ->
    MaxScore = fun(S, L, R) ->
        Score = fun(S, L, R, Acc) ->
            case string:find(S, L) of
                {ok, Pos} -> 
                    NewS = string:substring(S, 1, Pos - 1) ++ string:substring(S, Pos + string:length(L)),
                    Score(NewS, L, R, Acc + string:length(L));
                _ -> 
                    case string:find(S, R) of
                        {ok, Pos} -> 
                            NewS = string:substring(S, 1, Pos - 1) ++ string:substring(S, Pos + string:length(R)),
                            Score(NewS, L, R, Acc + string:length(R));
                        _ -> 
                            Acc
                    end
            end
        end,
        Score(S, L, R, 0)
    end,
    MaxScore(S, L, R).