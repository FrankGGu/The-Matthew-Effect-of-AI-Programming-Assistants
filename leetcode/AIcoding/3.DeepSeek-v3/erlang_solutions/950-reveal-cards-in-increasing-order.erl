-spec deck_revealed_increasing(Deck :: [integer()]) -> [integer()].
deck_revealed_increasing(Deck) ->
    Sorted = lists:sort(fun(A, B) -> A =< B end, Deck),
    queue_reveal(Sorted).

queue_reveal(Sorted) ->
    Q = queue:new(),
    Q1 = lists:foldl(fun(_, Acc) -> queue:in(0, Acc) end, Q, Sorted),
    {Result, _} = lists:foldl(fun(X, {QAcc, Res}) ->
        {Value, QAcc1} = queue:out(QAcc),
        QAcc2 = case queue:is_empty(QAcc1) of
            true -> QAcc1;
            false -> 
                {Value2, QAcc3} = queue:out(QAcc1),
                queue:in(Value2, QAcc3)
        end,
        {queue:in(X, QAcc2), [Value | Res]}
    end, {Q1, []}, lists:reverse(Sorted)),
    lists:reverse(element(2, {Result, []}))).