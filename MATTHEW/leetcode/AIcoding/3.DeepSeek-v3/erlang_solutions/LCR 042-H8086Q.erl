-record(state, {queue = queue:new()}).

init() ->
    #state{}.

ping(_State = #state{queue = Q}, T) ->
    NewQ = queue:in(T, Q),
    {Min, NewQ1} = remove_old(NewQ, T - 3000),
    Count = queue:len(NewQ1),
    {Count, #state{queue = NewQ1}}.

remove_old(Q, Min) ->
    case queue:peek(Q) of
        {value, T} when T < Min ->
            {_, Q1} = queue:out(Q),
            remove_old(Q1, Min);
        _ ->
            {Min, Q}
    end.