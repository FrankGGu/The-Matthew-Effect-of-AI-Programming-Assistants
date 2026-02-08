-spec k_concatenation_max_sum(Arr :: [integer()], K :: integer()) -> integer().
k_concatenation_max_sum(Arr, K) ->
    Mod = 1000000007,
    case K of
        1 ->
            max_subarray(Arr) rem Mod;
        _ ->
            Sum = lists:sum(Arr),
            case Sum > 0 of
                true ->
                    (max_prefix(Arr) + (K - 2) * Sum + max_suffix(Arr)) rem Mod;
                false ->
                    (max_prefix(Arr) + max_suffix(Arr)) rem Mod
            end
    end.

max_subarray(List) ->
    max_subarray(List, 0, 0).

max_subarray([], _, Max) -> Max;
max_subarray([H | T], Current, Max) ->
    NewCurrent = max(H, Current + H),
    NewMax = max(NewCurrent, Max),
    max_subarray(T, NewCurrent, NewMax).

max_prefix(List) ->
    max_prefix(List, 0, 0).

max_prefix([], _, Max) -> Max;
max_prefix([H | T], Sum, Max) ->
    NewSum = Sum + H,
    NewMax = max(NewSum, Max),
    max_prefix(T, NewSum, NewMax).

max_suffix(List) ->
    max_suffix(lists:reverse(List), 0, 0).

max_suffix([], _, Max) -> Max;
max_suffix([H | T], Sum, Max) ->
    NewSum = Sum + H,
    NewMax = max(NewSum, Max),
    max_suffix(T, NewSum, NewMax).