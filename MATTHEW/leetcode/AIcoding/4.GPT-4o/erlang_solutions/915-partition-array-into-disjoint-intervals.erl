-module(solution).
-export([partition/1]).

partition(A) ->
    N = length(A),
    partition_helper(A, N, 0, 0, 0).

partition_helper(A, N, i, left_max, right_min) ->
    case i of
        N -> N - 1;
        _ ->
            left_max1 = max(left_max, lists:nth(i + 1, A)),
            right_min1 = lists:nth(i + 1, A),
            case lists:all(fun(X) -> X <= left_max1 end, lists:sublist(A, i + 1)) of
                true -> partition_helper(A, N, i + 1, left_max1, right_min1);
                false -> left_max
            end
    end.