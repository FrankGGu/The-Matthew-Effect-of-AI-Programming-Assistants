-module(solution).
-export([max_sliding_window/2]).

-record(deque, {front = [], back = []}).

new_deque() -> #deque{}.
is_empty(#deque{front = [], back = []}) -> true;
is_empty(_) -> false.

rebalance_after_pop(#deque{front = F, back = B}) ->
    case {F, B} of
        {[], []} -> #deque{front = [], back = []};
        {[], _} -> %% Front is empty, move all from back to front
            #deque{front = lists:reverse(B), back = []};
        {_, []} -> %% Back is empty, move all from front to back
            #deque{front = [], back = lists:reverse(F)};
        _ -> #deque{front = F, back = B} %% Both non-empty, no rebalance needed
    end.

push_back(Val, #deque{front = F, back = B}) ->
    #deque{front = F, back = [Val|B]}.

peek_front(Deque) ->
    #deque{front = F, back = B} = Deque,
    case F of
        [H|_] -> H;
        [] -> %% Front is empty, but back might not be. Rebalance to get element.
            #deque{front = [H|_], _} = rebalance_after_pop(Deque),
            H
    end.

pop_front(Deque) ->
    #deque{front = F, back = B} = Deque,
    case F of
        [H|T] ->
            {H, rebalance_after_pop(#deque{front = T, back = B})};
        [] -> %% Front is empty, but back might not be. Rebalance to get element.
            #deque{front = [H|T], back = NewB} = rebalance_after_pop(Deque),
            {H, rebalance_after_pop(#deque{front = T, back = NewB})}
    end.

peek_back(Deque) ->
    #deque{front = F, back = B} = Deque,
    case B of
        [H|_] -> H;
        [] -> %% Back is empty, but front might not be. Rebalance to get element.
            #deque{front = _, back = [H|_]} = rebalance_after_pop(Deque),
            H
    end.

pop_back(Deque) ->
    #deque{front = F, back = B} = Deque,
    case B of
        [H|T] ->
            {H, rebalance_after_pop(#deque{front = F, back = T})};
        [] -> %% Back is empty, but front might not be. Rebalance to get element.
            #deque{front = NewF, back = [H|T]} = rebalance_after_pop(Deque),
            {H, rebalance_after_pop(#deque{front = NewF, back = T})}
    end.

max_sliding_window(Nums, K) ->
    Len = length(Nums),
    %% Convert list to tuple for O(1) access by index (1-based)
    NumsTuple = list_to_tuple(Nums),

    %% Use an accumulator for the result list to build it in reverse, then reverse once at the end.
    Result = max_sliding_window_loop(0, Len, K, NumsTuple, new_deque(), []),
    lists:reverse(Result).

max_sliding_window_loop(I, Len, K, NumsTuple, Deque, AccResult) when I < Len ->
    %% 1. Remove elements from the front of Deque that are out of the current window
    %%    An index `idx` is out of window if `idx < I - K + 1`.
    Deque1 = remove_out_of_window(I, K, Deque),

    %% 2. Remove elements from the back of Deque whose values are smaller than or equal to the current element's value
    CurrentVal = element(I + 1, NumsTuple), %% NumsTuple is 1-indexed
    Deque2 = remove_smaller_from_back(CurrentVal, NumsTuple, Deque1),

    %% 3. Add the current element's index to the back of Deque
    Deque3 = push_back(I, Deque2),

    %% 4. If the window has formed (I >= K - 1), add the maximum to the result
    case I >= K - 1 of
        true ->
            MaxIdx = peek_front(Deque3), %% Index of the maximum element in the current window
            MaxVal = element(MaxIdx + 1, NumsTuple),
            max_sliding_window_loop(I + 1, Len, K, NumsTuple, Deque3, [MaxVal | AccResult]);
        false ->
            max_sliding_window_loop(I + 1, Len, K, NumsTuple, Deque3, AccResult)
    end;
max_sliding_window_loop(_I, _Len, _K, _NumsTuple, _Deque, AccResult) ->
    AccResult.

remove_out_of_window(CurrentIdx, K, Deque) ->
    case is_empty(Deque) of
        true -> Deque;
        false ->
            FrontIdx = peek_front(Deque),
            case FrontIdx < (CurrentIdx - K + 1) of
                true ->
                    {_RemovedIdx, Deque1} = pop_front(Deque),
                    remove_out_of_window(CurrentIdx, K, Deque1);
                false ->
                    Deque
            end
    end.

remove_smaller_from_back(CurrentVal, NumsTuple, Deque) ->
    case is_empty(Deque) of
        true -> Deque;
        false ->
            BackIdx = peek_back(Deque),
            BackVal = element(BackIdx + 1, NumsTuple),
            case BackVal =< CurrentVal of
                true ->
                    {_RemovedIdx, Deque1} = pop_back(Deque),
                    remove_smaller_from_back(CurrentVal, NumsTuple, Deque1);
                false ->
                    Deque
            end
    end.