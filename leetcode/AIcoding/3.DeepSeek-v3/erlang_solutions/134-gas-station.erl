-spec can_complete_circuit(Gas :: [integer()], Cost :: [integer()]) -> integer().
can_complete_circuit(Gas, Cost) ->
    Total = 0,
    Current = 0,
    Start = 0,
    {FinalTotal, FinalStart} = lists:foldl(fun(I, {T, C, S}) ->
        NewT = T + lists:nth(I + 1, Gas) - lists:nth(I + 1, Cost),
        NewC = C + lists:nth(I + 1, Gas) - lists:nth(I + 1, Cost),
        if
            NewC < 0 ->
                {NewT, 0, I + 1};
            true ->
                {NewT, NewC, S}
        end
    end, {Total, Current, Start}, lists:seq(0, length(Gas) - 1)),
    if
        FinalTotal >= 0 ->
            FinalStart;
        true ->
            -1
    end.