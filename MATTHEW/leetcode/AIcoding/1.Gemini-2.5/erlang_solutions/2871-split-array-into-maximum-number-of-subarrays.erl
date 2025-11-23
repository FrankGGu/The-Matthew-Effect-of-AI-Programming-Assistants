-spec max_subarrays(Nums :: [integer()]) -> integer().
max_subarrays(Nums) ->
    {Result, _} = lists:foldl(
        fun(Num, {Count, CurrentAnd}) ->
            NewCurrentAnd =
                if CurrentAnd == -1 ->
                    Num;
                true ->
                    CurrentAnd band Num
                end,
            if NewCurrentAnd > 0 ->
                % If the bitwise AND of the current subarray (ending with Num) is positive,
                % we've found a valid subarray. We maximize the count by ending it here
                % and starting a new one.
                {Count + 1, -1}; % Increment count, reset CurrentAnd to -1 to signify starting a new subarray
            true ->
                % If the bitwise AND is 0 or less, this subarray is not yet valid (or became invalid).
                % We continue extending it. If it's 0, it will remain 0 for subsequent ANDs.
                {Count, NewCurrentAnd}
            end
        end,
        {0, -1}, % Initial state: {count, current_and}. -1 acts as an "all bits set" mask for the first element.
        Nums
    ),
    Result.