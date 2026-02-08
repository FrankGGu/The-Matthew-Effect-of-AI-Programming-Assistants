-module(solution).
-export([max_score/1]).

max_score(Array) ->
    N = length(Array),
    lists:foldl(fun(X, {Pos, Score}) ->
        NewPos = Pos + X,
        NewScore = Score + if
            NewPos > N -> 0;
            true -> Array[NewPos - 1]
        end,
        {NewPos, NewScore}
    end, {1, 0}, Array).