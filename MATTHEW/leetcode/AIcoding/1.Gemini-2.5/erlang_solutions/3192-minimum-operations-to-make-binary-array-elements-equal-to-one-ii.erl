-module(solution).
-export([min_operations/1]).

-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    min_operations_acc(Nums, 0, 0).

min_operations_acc([], _CurrentFlips, Operations) ->
    Operations;
min_operations_acc([H | T], CurrentFlips, Operations) ->
    EffectiveValue = H bxor (CurrentFlips band 1),
    case EffectiveValue of
        0 ->
            min_operations_acc(T, CurrentFlips + 1, Operations + 1);
        1 ->
            min_operations_acc(T, CurrentFlips, Operations)
    end.