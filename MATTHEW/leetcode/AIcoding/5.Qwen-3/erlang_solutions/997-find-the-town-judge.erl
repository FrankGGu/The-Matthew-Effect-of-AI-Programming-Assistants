-module(town_judge).
-export([find_judge/1]).

find_judge(Num) when is_integer(Num) ->
    find_judge(Num, 0, 0).

find_judge(_, _, _) when Num < 1 ->
    -1;

find_judge(Num, Votes, Judge) ->
    case Judge of
        0 ->
            find_judge(Num, Votes, 1);
        _ ->
            if
                Votes == Num - 1 ->
                    Judge;
                true ->
                    find_judge(Num, Votes + 1, Judge + 1)
            end
    end.