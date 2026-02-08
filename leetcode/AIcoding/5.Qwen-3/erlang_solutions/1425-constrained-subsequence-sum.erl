-module(solution).
-export([constrained_subsequence_sum/2]).

constrained_subsequence_sum(Nums, k) ->
    Len = length(Nums),
    Q = queue:new(),
    DP = array:new(Len, {default, 0}),
    Result = 0,
    loop(0, Nums, k, Q, DP, Result).

loop(I, _Nums, _K, _Q, _DP, Result) when I >= length(_Nums) ->
    Result;
loop(I, Nums, K, Q, DP, Result) ->
    Current = array:get(I, DP),
    if
        I == 0 ->
            NewCurrent = lists:nth(I+1, Nums);
        true ->
            MaxPrev = max_prev(Q, I, K),
            NewCurrent = MaxPrev + lists:nth(I+1, Nums)
    end,
    array:set(I, NewCurrent, DP),
    % Maintain the deque: remove elements from the back that are smaller than current
    while queue:is_empty(Q) == false and (array:get(queue:peek_last(Q), DP) < NewCurrent) do
        Q1 = queue:drop(Q),
        Q2 = queue:in(I, Q1),
        Q = Q2
    end,
    Q1 = queue:in(I, Q),
    % Remove elements from the front that are out of window
    while queue:peek_first(Q) =< I - K do
        Q2 = queue:drop(Q),
        Q = Q2
    end,
    loop(I+1, Nums, K, Q1, DP, max(Result, NewCurrent)).

max_prev(Q, I, K) ->
    case queue:peek_first(Q) of
        {ok, J} when J >= I - K ->
            array:get(J, DP);
        _ ->
            0
    end.