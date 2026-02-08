-spec count_good_subarrays(Arr :: [integer()]) -> integer().
count_good_subarrays(Arr) ->
    count_good_subarrays(Arr, 0, 0).

count_good_subarrays([A, B, C | Rest], Index, Count) ->
    NewCount = if
        (A =:= B) or (A =:= C) or (B =:= C) -> Count;
        true -> Count + 1
    end,
    count_good_subarrays([B, C | Rest], Index + 1, NewCount);
count_good_subarrays(_, _, Count) ->
    Count.