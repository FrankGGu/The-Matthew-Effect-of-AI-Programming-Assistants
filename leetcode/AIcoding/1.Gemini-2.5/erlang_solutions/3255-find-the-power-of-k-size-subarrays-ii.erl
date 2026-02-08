-module(solution).
-export([max_sliding_window/2]).

max_sliding_window(Nums, K) ->
    lists:reverse(max_sliding_window_helper(Nums, K, 0, queue:new(), [])).

max_sliding_window_helper([], _K, _CurrentIndex, _Deque, AccResult) ->
    AccResult;
max_sliding_window_helper([H|T], K, CurrentIndex, Deque, AccResult) ->
    CleanedDeque1 = clean_deque_front(Deque, CurrentIndex - K),
    CleanedDeque2 = clean_deque_back(CleanedDeque1, H),
    DequeWithCurrent = queue:in({H, CurrentIndex}, CleanedDeque2),

    NewAccResult =
        if CurrentIndex >= K - 1 ->
            {value, {MaxVal, _MaxIdx}} = queue:peek_front(DequeWithCurrent),
            [MaxVal | AccResult];
        true ->
            AccResult
        end,

    max_sliding_window_helper(T, K, CurrentIndex + 1, DequeWithCurrent, NewAccResult).

clean_deque_front(Deque, OldestAllowedIndex) ->
    case queue:peek_front(Deque) of
        {value, {_Val, Idx}} when Idx =< OldestAllowedIndex ->
            {_OutElement, RestDeque} = queue:out(Deque),
            clean_deque_front(RestDeque, OldestAllowedIndex);
        _ ->
            Deque
    end.

clean_deque_back(Deque, CurrentValue) ->
    case queue:peek_back(Deque) of
        {value, {Val, _Idx}} when Val =< CurrentValue ->
            {_OutElement, RestDeque} = queue:out_back(Deque),
            clean_deque_back(RestDeque, CurrentValue);
        _ ->
            Deque
    end.