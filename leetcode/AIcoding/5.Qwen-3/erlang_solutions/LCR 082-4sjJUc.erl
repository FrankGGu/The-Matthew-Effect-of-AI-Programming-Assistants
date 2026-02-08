-module(combinationsum2).
-export([combination_sum/2]).

combination_sum(Nums, Target) ->
    lists:sort(combination_sum(Nums, Target, [], [])).

combination_sum([], _, _, Acc) ->
    Acc;
combination_sum([N | T], Target, Path, Acc) ->
    case N of
        _ when N > Target ->
            combination_sum(T, Target, Path, Acc);
        _ ->
            NewPath = [N | Path],
            NewTarget = Target - N,
            if
                NewTarget == 0 ->
                    combination_sum(T, Target, Path, [lists:reverse(NewPath) | Acc]);
                NewTarget < 0 ->
                    combination_sum(T, Target, Path, Acc);
                true ->
                    combination_sum(T, Target, NewPath, Acc)
            end
    end.

combination_sum([], _, _, Acc) ->
    Acc;
combination_sum([N | T], Target, Path, Acc) ->
    combination_sum(T, Target, Path, Acc).