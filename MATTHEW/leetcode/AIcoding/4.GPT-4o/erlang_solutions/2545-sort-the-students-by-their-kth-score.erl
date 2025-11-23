-module(solution).
-export([sort_students/2]).

sort_students(Students, K) ->
    lists:sort(fun({_, Scores1}, {_, Scores2}) ->
        case lists:nth(K + 1, Scores1) < lists:nth(K + 1, Scores2) of
            true -> true;
            false -> case lists:nth(K + 1, Scores1) > lists:nth(K + 1, Scores2) of
                true -> false;
                false -> lists:nth(1, Scores1) < lists:nth(1, Scores2)
            end
        end
    end, Students).