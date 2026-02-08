-module(combinationsumii).
-export([combination_sum/2]).

combination_sum(Nums, Target) ->
    lists:sort(combination_sum(Nums, Target, [], 0, [])).

combination_sum([], _, _, _, Acc) ->
    Acc;
combination_sum([H | T], Target, Path, Start, Acc) ->
    case H of
        _ when H > Target ->
            combination_sum(T, Target, Path, Start, Acc);
        _ ->
            NewTarget = Target - H,
            if
                NewTarget < 0 ->
                    combination_sum(T, Target, Path, Start, Acc);
                NewTarget == 0 ->
                    combination_sum(T, Target, Path, Start, [lists:reverse([H | Path]) | Acc]);
                true ->
                    combination_sum(T, Target, [H | Path], Start + 1, [lists:reverse([H | Path]) | Acc])
            end
    end.

combination_sum(_, _, _, _, Acc) ->
    Acc.