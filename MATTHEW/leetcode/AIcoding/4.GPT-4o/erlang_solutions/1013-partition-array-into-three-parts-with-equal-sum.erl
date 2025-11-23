-module(solution).
-export([can_partition/1]).

can_partition(Array) ->
    Total = lists:sum(Array),
    if
        Total rem 3 /= 0 -> false;
        true ->
            Target = Total div 3,
            can_partition_helper(Array, Target, 0, 0)
    end.

can_partition_helper([], Target, CurrentSum, PartCount) ->
    PartCount =:= 3;
can_partition_helper([H | T], Target, CurrentSum, PartCount) ->
    NewSum = CurrentSum + H,
    case NewSum of
        Target ->
            can_partition_helper(T, Target, 0, PartCount + 1);
        _ when NewSum < Target ->
            can_partition_helper(T, Target, NewSum, PartCount);
        _ ->
            false
    end.