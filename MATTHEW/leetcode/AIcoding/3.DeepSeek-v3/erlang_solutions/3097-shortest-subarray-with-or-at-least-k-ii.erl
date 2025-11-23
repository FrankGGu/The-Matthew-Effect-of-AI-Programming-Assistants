-spec shortest_subarray(Nums :: [integer()], K :: integer()) -> integer().
shortest_subarray(Nums, K) ->
    case K =:= 0 of
        true -> 1;
        false ->
            shortest_subarray(Nums, K, 0, 0, length(Nums) + 1, 0, [])
    end.

shortest_subarray([], _K, _CurrOr, _Left, MinLen, _TotalOr, _Queue) ->
    case MinLen =:= length(Nums) + 1 of
        true -> -1;
        false -> MinLen
    end;
shortest_subarray([Num | Rest], K, CurrOr, Left, MinLen, TotalOr, Queue) ->
    NewTotalOr = TotalOr bor Num,
    NewQueue = [{Num, Left} | Queue],
    {NewCurrOr, NewLeft, NewMinLen, NewQueue1} = 
        update_queue(NewTotalOr, K, Left + 1, MinLen, NewQueue),
    shortest_subarray(Rest, K, NewCurrOr, NewLeft, NewMinLen, NewTotalOr, NewQueue1).

update_queue(TotalOr, K, Right, MinLen, Queue) ->
    case Queue of
        [] -> {0, Right, MinLen, []};
        [{Num, Left} | Rest] ->
            case (TotalOr bxor (TotalOr band (Num - 1))) >= K of
                true ->
                    NewMinLen = min(MinLen, Right - Left),
                    update_queue(TotalOr bxor Num, K, Right, NewMinLen, Rest);
                false ->
                    {TotalOr, Right, MinLen, Queue}
            end
    end.