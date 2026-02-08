-module(solution).
-export([count_repetitions/2]).

count_repetitions(Def, Num) ->
    count_repetitions(Def, Num, 0, 0, 1).

count_repetitions(_, _, Count, _, _) when Count >= Num ->
    Count;
count_repetitions(Def, Num, Count, Index, Step) ->
    Len = length(Def),
    if
        Index >= Len ->
            count_repetitions(Def, Num, Count, 0, Step + 1);
        true ->
            case lists:nth(Index + 1, Def) of
                $A -> count_repetitions(Def, Num, Count + 1, Index + 1, Step);
                _ -> count_repetitions(Def, Num, Count, Index + 1, Step)
            end
    end.