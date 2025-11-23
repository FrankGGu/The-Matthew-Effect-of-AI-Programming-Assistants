-module(reach_end_of_array_with_max_score).
-export([max_score/1]).

max_score(Nums) ->
    N = length(Nums),
    {Max, _} = lists:foldl(fun(I, {CurrentMax, CurrentScore}) ->
        if
            I == 0 -> {CurrentMax, CurrentScore + element(I+1, Nums)};
            true ->
                NewScore = CurrentScore + element(I+1, Nums),
                if
                    I == N-1 -> {CurrentMax, NewScore};
                    true ->
                        NextMax = max(CurrentMax, NewScore),
                        {NextMax, NewScore}
                end
        end
    end, {0, 0}, lists:seq(0, N-1)),
    Max.