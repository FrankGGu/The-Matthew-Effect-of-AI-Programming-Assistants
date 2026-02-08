-spec order_of_largest_plus_sign(N :: integer(), Mines :: [[integer()]]) -> integer().
order_of_largest_plus_sign(N, Mines) ->
    Banned = sets:from_list([{R, C} || [R, C] <- Mines]),
    DP = array:new(N, {default, array:new(N, {default, N})}),

    DP1 = lists:foldl(fun(I, Acc) ->
        Count = 0,
        lists:foldl(fun(J, {DPAcc, Cnt}) ->
            case sets:is_element({I, J}, Banned) of
                true -> {DPAcc, 0};
                false -> 
                    NewCnt = Cnt + 1,
                    Row = array:get(I, DPAcc),
                    NewRow = array:set(J, min(NewCnt, array:get(J, Row)), Row),
                    {array:set(I, NewRow, DPAcc), NewCnt}
            end
        end, {Acc, Count}, lists:seq(0, N-1))
    end, DP, lists:seq(0, N-1)),

    DP2 = lists:foldl(fun(I, Acc) ->
        Count = 0,
        lists:foldl(fun(J, {DPAcc, Cnt}) ->
            case sets:is_element({I, J}, Banned) of
                true -> {DPAcc, 0};
                false -> 
                    NewCnt = Cnt + 1,
                    Row = array:get(I, DPAcc),
                    NewRow = array:set(J, min(NewCnt, array:get(J, Row)), Row),
                    {array:set(I, NewRow, DPAcc), NewCnt}
            end
        end, {Acc, Count}, lists:reverse(lists:seq(0, N-1)))
    end, DP1, lists:seq(0, N-1)),

    DP3 = lists:foldl(fun(J, Acc) ->
        Count = 0,
        lists:foldl(fun(I, {DPAcc, Cnt}) ->
            case sets:is_element({I, J}, Banned) of
                true -> {DPAcc, 0};
                false -> 
                    NewCnt = Cnt + 1,
                    Row = array:get(I, DPAcc),
                    NewRow = array:set(J, min(NewCnt, array:get(J, Row)), Row),
                    {array:set(I, NewRow, DPAcc), NewCnt}
            end
        end, {Acc, Count}, lists:seq(0, N-1))
    end, DP2, lists:seq(0, N-1)),

    DP4 = lists:foldl(fun(J, Acc) ->
        Count = 0,
        lists:foldl(fun(I, {DPAcc, Cnt}) ->
            case sets:is_element({I, J}, Banned) of
                true -> {DPAcc, 0};
                false -> 
                    NewCnt = Cnt + 1,
                    Row = array:get(I, DPAcc),
                    NewRow = array:set(J, min(NewCnt, array:get(J, Row)), Row),
                    {array:set(I, NewRow, DPAcc), NewCnt}
            end
        end, {Acc, Count}, lists:reverse(lists:seq(0, N-1)))
    end, DP3, lists:seq(0, N-1)),

    MaxOrder = lists:foldl(fun(I, Max) ->
        lists:foldl(fun(J, CurrentMax) ->
            Row = array:get(I, DP4),
            Val = array:get(J, Row),
            max(CurrentMax, Val)
        end, Max, lists:seq(0, N-1))
    end, 0, lists:seq(0, N-1)),

    MaxOrder.