-module(solution).
-export([maximum_operations/2]).

maximum_operations(ops, nums) ->
    maximum_operations_helper(ops, nums, 0, 0).

maximum_operations_helper(0, _, Count, _) ->
    Count;
maximum_operations_helper(OpsLeft, [], Count, _) ->
    Count;
maximum_operations_helper(OpsLeft, [H | T], Count, Sum) ->
    NewSum = Sum + H,
    maximum_operations_helper(OpsLeft - 1, T, Count + 1, NewSum);
maximum_operations_helper(OpsLeft, [H | T], Count, Sum) ->
    maximum_operations_helper(OpsLeft, T, Count, Sum).