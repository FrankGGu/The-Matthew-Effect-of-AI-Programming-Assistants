-spec min_days(BlossomDay :: [integer()], M :: integer(), K :: integer()) -> integer().
min_days(BlossomDay, M, K) ->
    case M * K > length(BlossomDay) of
        true -> -1;
        false ->
            Min = lists:min(BlossomDay),
            Max = lists:max(BlossomDay),
            binary_search(BlossomDay, M, K, Min, Max)
    end.

binary_search(BlossomDay, M, K, Left, Right) when Left < Right ->
    Mid = Left + (Right - Left) div 2,
    case can_make(BlossomDay, M, K, Mid) of
        true -> binary_search(BlossomDay, M, K, Left, Mid);
        false -> binary_search(BlossomDay, M, K, Mid + 1, Right)
    end;
binary_search(BlossomDay, M, K, Left, _Right) ->
    case can_make(BlossomDay, M, K, Left) of
        true -> Left;
        false -> -1
    end.

can_make(BlossomDay, M, K, Day) ->
    {Count, Bouquets} = lists:foldl(fun(D, {Cnt, Bq}) ->
        if D =< Day ->
            NewCnt = Cnt + 1,
            if NewCnt >= K -> {0, Bq + 1};
               true -> {NewCnt, Bq}
            end;
        true -> {0, Bq}
        end
    end, {0, 0}, BlossomDay),
    Bouquets >= M.