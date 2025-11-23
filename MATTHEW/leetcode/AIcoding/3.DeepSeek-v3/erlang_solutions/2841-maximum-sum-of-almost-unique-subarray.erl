-spec max_sum(Nums :: [integer()], M :: integer(), K :: integer()) -> integer().
max_sum(Nums, M, K) ->
    {_, MaxSum} = lists:foldl(
        fun(Num, {Window, {CurrentSum, MaxSum, Count}}) ->
            NewWindow = case length(Window) >= K of
                true -> tl(Window) ++ [Num];
                false -> Window ++ [Num]
            end,
            NewCurrentSum = case length(Window) >= K of
                true -> CurrentSum - hd(Window) + Num;
                false -> CurrentSum + Num
            end,
            NewCount = case length(Window) >= K of
                true ->
                    case lists:member(hd(Window), tl(Window)) of
                        false -> Count - 1;
                        true -> Count
                    end;
                false -> length(lists:usort(NewWindow))
            end,
            NewCount2 = case lists:member(Num, Window) of
                false -> NewCount + 1;
                true -> NewCount
            end,
            NewMaxSum = if
                NewCount2 >= M andalso NewCurrentSum > MaxSum -> NewCurrentSum;
                true -> MaxSum
            end,
            {NewWindow, {NewCurrentSum, NewMaxSum, NewCount2}}
        end,
        {[], {0, 0, 0}},
        Nums
    ),
    MaxSum.