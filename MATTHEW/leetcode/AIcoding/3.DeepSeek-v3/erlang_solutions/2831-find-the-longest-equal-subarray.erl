-spec longest_equal_subarray(Nums :: [integer()], K :: integer()) -> integer().
longest_equal_subarray(Nums, K) ->
    Counts = maps:new(),
    MaxCount = 0,
    Left = 1,
    {MaxCount, _} = lists:foldl(fun(Num, {CurrentMax, CurrentLeft}) ->
        Count = maps:get(Num, Counts, 0) + 1,
        Counts1 = maps:put(Num, Count, Counts),
        WindowSize = CurrentLeft - Left + 1,
        if
            WindowSize - Count > K ->
                LeftNum = lists:nth(Left, Nums),
                Counts2 = maps:update_with(LeftNum, fun(V) -> V - 1 end, Counts1),
                {max(CurrentMax, Count), Left + 1, Counts2};
            true ->
                {max(CurrentMax, Count), CurrentLeft, Counts1}
        end
    end, {MaxCount, Left, Counts}, lists:seq(1, length(Nums))),
    MaxCount.