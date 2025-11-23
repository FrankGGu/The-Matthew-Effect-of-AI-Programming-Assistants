-module(small_rotation).
-export([best_rotation/1]).

best_rotation(Numbers) ->
    N = length(Numbers),
    Scores = array:new(N, {default, 0}),
    lists:foreach(fun(I) ->
        A = lists:nth(I + 1, Numbers),
        B = lists:nth((I + 1) rem N + 1, Numbers),
        if
            A > B -> array:set(I, array:get(I, Scores) + 1, Scores);
            true -> ok
        end
    end, lists:seq(0, N - 1)),
    find_max_index(Scores, 0, 0, 0).

find_max_index(Scores, Index, MaxIndex, MaxScore) ->
    case Index < array:size(Scores) of
        true ->
            Score = array:get(Index, Scores),
            if
                Score > MaxScore -> find_max_index(Scores, Index + 1, Index, Score);
                true -> find_max_index(Scores, Index + 1, MaxIndex, MaxScore)
            end;
        false -> MaxIndex
    end.