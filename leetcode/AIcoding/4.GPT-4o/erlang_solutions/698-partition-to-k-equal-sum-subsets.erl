-module(solution).
-export([can_partition/2]).

can_partition(Nums, K) ->
    Sum = lists:sum(Nums),
    if
        Sum rem K /= 0 -> false;
        true -> can_partition_helper(Nums, K, Sum div K, [], [])
    end.

can_partition_helper([], 0, 0, _, _) -> true;
can_partition_helper(_, 0, _, _, _) -> false;
can_partition_helper([H | T], K, Target, Used, Current) ->
    case lists:sum(Current) + H =< Target of
        true ->
            can_partition_helper(T, K, Target, Used, [H | Current]) orelse
            can_partition_helper(T, K, Target, [H | Used], []);
        false -> can_partition_helper(T, K - 1, Target, [], [])
    end;
can_partition_helper([], _, _, _, _) -> false.