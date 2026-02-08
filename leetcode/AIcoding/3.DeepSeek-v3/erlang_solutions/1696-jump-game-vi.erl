-spec max_result(Nums :: [integer()], K :: integer()) -> integer().
max_result(Nums, K) ->
    {ok, DP} = array:new([{size, length(Nums)}, {default, 0}]),
    DP1 = array:set(0, hd(Nums), DP),
    Deque = queue:from_list([0]),
    {Result, _} = lists:foldl(fun(I, {DPAcc, QAcc}) ->
        Value = array:get(I, DPAcc),
        QAcc1 = clean_deque(QAcc, I, K),
        QAcc2 = queue:in(I, QAcc1),
        {MaxIdx, QAcc3} = queue:out(QAcc2),
        MaxVal = array:get(MaxIdx, DPAcc),
        NewVal = MaxVal + lists:nth(I + 1, Nums),
        DPAcc1 = array:set(I + 1, NewVal, DPAcc),
        QAcc4 = clean_deque_insert(QAcc3, I + 1, DPAcc1),
        {DPAcc1, QAcc4}
    end, {DP1, Deque}, lists:seq(1, length(Nums) - 1)),
    array:get(length(Nums) - 1, Result).

clean_deque(Q, I, K) ->
    case queue:is_empty(Q) of
        true -> Q;
        false ->
            {Front, Q1} = queue:out(Q),
            if
                Front < I - K -> clean_deque(Q1, I, K);
                true -> queue:in(Front, Q1)
            end
    end.

clean_deque_insert(Q, I, DP) ->
    case queue:is_empty(Q) of
        true -> queue:in(I, Q);
        false ->
            {Last, Q1} = queue:out_r(Q),
            LastVal = array:get(Last, DP),
            IVal = array:get(I, DP),
            if
                IVal >= LastVal -> clean_deque_insert(Q1, I, DP);
                true -> queue:in(Last, queue:in(I, Q1))
            end
    end.