-module(solution).
-export([find_mirror_score/1]).

find_mirror_score(Str) ->
    Mirror = lists:reverse(Str),
    Score = lists:foldl(fun({C1, C2}, Acc) ->
        if 
            C1 =:= C2 -> Acc + 1; 
            true -> Acc 
        end
    end, 0, lists:zip(Str, Mirror)),
    Score.