-module(maximum_score_from_removing_substrings).
-export([maximumScore/2]).

maximumScore(S, P) ->
    Max = 0,
    lists:foldl(fun({A, B}, Acc) -> 
        case string:find(S, A) of
            nomatch -> Acc;
            {Pos, _} -> 
                NewS = string:substr(S, 1, Pos) ++ string:substr(S, Pos + length(A) + 1),
                Score = B + maximumScore(NewS, P),
                max(Acc, Score)
        end
    end, Max, P).