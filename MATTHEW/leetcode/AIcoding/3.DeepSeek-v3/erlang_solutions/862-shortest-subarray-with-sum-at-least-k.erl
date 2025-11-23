-module(shortest_subarray).

-export([shortest_subarray/2]).

shortest_subarray(Nums, K) ->
    N = length(Nums),
    P = [0 | lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Nums)],
    PRev = lists:reverse(P),
    Deque = queue:new(),
    MinLen = N + 1,
    {Result, _} = lists:foldl(fun(I, {Min, Q}) ->
        Pi = lists:nth(I, PRev),
        while_deque(Q, Pi, K, PRev),
        case queue:is_empty(Q) of
            false ->
                {J, _} = queue:get_r(Q),
                CurrentMin = min(Min, I - J);
            true ->
                CurrentMin = Min
        end,
        while_deque2(Q, Pi, PRev),
        Q1 = queue:in_r(I, Q),
        {CurrentMin, Q1}
    end, {MinLen, Deque}, lists:seq(1, N + 1)),
    if
        Result =< N -> Result;
        true -> -1
    end.

while_deque(Q, Pi, K, PRev) ->
    case queue:is_empty(Q) of
        false ->
            {J, _} = queue:get(Q),
            Pj = lists:nth(J, PRev),
            if
                Pi - Pj >= K ->
                    {_, Q1} = queue:out(Q),
                    while_deque(Q1, Pi, K, PRev);
                true ->
                    ok
            end;
        true ->
            ok
    end.

while_deque2(Q, Pi, PRev) ->
    case queue:is_empty(Q) of
        false ->
            {J, _} = queue:get_r(Q),
            Pj = lists:nth(J, PRev),
            if
                Pj >= Pi ->
                    {_, Q1} = queue:out_r(Q),
                    while_deque2(Q1, Pi, PRev);
                true ->
                    ok
            end;
        true ->
            ok
    end.