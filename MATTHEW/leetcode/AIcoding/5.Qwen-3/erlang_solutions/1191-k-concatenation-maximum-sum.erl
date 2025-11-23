-module(k_concatenation_max_sum).
-export([k_concatenation/2]).

k_concatenation(A, K) ->
    MaxSubarray = max_subarray(A),
    if
        K == 1 ->
            MaxSubarray;
        true ->
            Total = lists:sum(A),
            MaxPrefix = max_prefix(A),
            MaxSuffix = max_suffix(A),
            case MaxSubarray of
                0 ->
                    max(Total * K, MaxPrefix + MaxSuffix);
                _ ->
                    max(MaxSubarray + max(0, (K - 2) * Total), MaxPrefix + MaxSuffix)
            end
    end.

max_subarray([]) -> 0;
max_subarray([H | T]) ->
    max_subarray(H, T, H, 0).

max_subarray(_, [], Current, Max) ->
    max(Current, Max);
max_subarray(First, [H | T], Current, Max) ->
    NewCurrent = max(H, Current + H),
    NewMax = max(Max, NewCurrent),
    max_subarray(First, T, NewCurrent, NewMax).

max_prefix([]) -> 0;
max_prefix([H | T]) ->
    max_prefix(H, T, H, H).

max_prefix(_, [], Current, Max) ->
    Max;
max_prefix(First, [H | T], Current, Max) ->
    NewCurrent = Current + H,
    NewMax = max(Max, NewCurrent),
    max_prefix(First, T, NewCurrent, NewMax).

max_suffix([]) -> 0;
max_suffix([H | T]) ->
    max_suffix(H, T, H, H).

max_suffix(_, [], Current, Max) ->
    Max;
max_suffix(First, [H | T], Current, Max) ->
    NewCurrent = Current + H,
    NewMax = max(Max, NewCurrent),
    max_suffix(First, T, NewCurrent, NewMax).