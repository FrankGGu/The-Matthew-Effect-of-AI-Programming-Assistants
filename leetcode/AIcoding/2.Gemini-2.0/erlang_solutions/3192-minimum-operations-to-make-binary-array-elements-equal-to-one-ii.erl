-module(minimum_operations_equal_one_ii).
-export([min_operations/1]).

min_operations(Nums) ->
    min_ops(Nums, 0, 0).

min_ops([], _, Count) ->
    Count;
min_ops([1|Rest], Prev, Count) ->
    min_ops(Rest, 1, Count);
min_ops([0|Rest], 0, Count) ->
    min_ops(Rest, 0, Count);
min_ops([0|Rest], 1, Count) ->
    case Rest of
        [] ->
            Count + 1;
        [1|_] ->
            min_ops(Rest, 1, Count + 1);
        _ ->
            case lists:nth(2, [0|Rest]) of
                0 ->
                    min_ops(lists:nthtail(2, [0|Rest]), 0, Count + 1);
                1 ->
                    min_ops(lists:nthtail(1, [0|Rest]), 1, Count + 1)
            end
    end.