-spec zero_filled_subarray(Nums :: [integer()]) -> integer().
zero_filled_subarray(Nums) ->
    zero_filled_subarray(Nums, 0, 0).

zero_filled_subarray([], Count, Current) ->
    Count + (Current * (Current + 1)) div 2;
zero_filled_subarray([0 | Rest], Count, Current) ->
    zero_filled_subarray(Rest, Count, Current + 1);
zero_filled_subarray([_ | Rest], Count, Current) ->
    zero_filled_subarray(Rest, Count + (Current * (Current + 1)) div 2, 0).