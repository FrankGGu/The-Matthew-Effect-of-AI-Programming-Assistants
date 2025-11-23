-spec count_alternating_subarrays(Nums :: [integer()]) -> integer().
count_alternating_subarrays(Nums) ->
    count_alternating_subarrays(Nums, 0, 1, 1).

count_alternating_subarrays([_], Total, Current, _) ->
    Total + Current;
count_alternating_subarrays([A, B | Rest], Total, Current, Prev) when (A =/= B) ->
    NewCurrent = Current + 1,
    count_alternating_subarrays([B | Rest], Total, NewCurrent, B);
count_alternating_subarrays([A, B | Rest], Total, Current, _) ->
    NewTotal = Total + Current * (Current + 1) div 2,
    count_alternating_subarrays([B | Rest], NewTotal, 1, B).