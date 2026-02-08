-module(sliding_window_median).
-export([medianSlidingWindow/3]).

medianSlidingWindow(Nums, K, Result) ->
    lists:reverse(medianSlidingWindow(Nums, K, [], [], Result, 1)).

medianSlidingWindow([], _K, Left, Right, Result, _Index) ->
    Result;
medianSlidingWindow([H|T], K, Left, Right, Result, Index) ->
    {NewLeft, NewRight} = insert(H, Left, Right),
    {BalancedLeft, BalancedRight} = balance(NewLeft, NewRight),
    case Index >= K of
        true ->
            Median = median(BalancedLeft, BalancedRight),
            {UpdatedLeft, UpdatedRight} = remove(lists:nth(Index - K + 1, Nums), BalancedLeft, BalancedRight),
            {NewBalancedLeft, NewBalancedRight} = balance(UpdatedLeft, UpdatedRight),
            medianSlidingWindow(T, K, NewBalancedLeft, NewBalancedRight, [Median|Result], Index + 1);
        false ->
            medianSlidingWindow(T, K, BalancedLeft, BalancedRight, Result, Index + 1)
    end.

insert(Num, Left, Right) ->
    case Left of
        [] ->
            {Left, [Num]};
        [H|_] ->
            case Num =< H of
                true ->
                    {lists:sort([Num|Left]), Right};
                false ->
                    {Left, lists:sort([Num|Right])}
            end
    end.

remove(Num, Left, Right) ->
    case lists:member(Num, Left) of
        true ->
            {lists:delete(Num, Left), Right};
        false ->
            {Left, lists:delete(Num, Right)}
    end.

balance(Left, Right) ->
    LeftSize = length(Left),
    RightSize = length(Right),
    case LeftSize - RightSize of
        2 ->
            {lists:sublist(Left, LeftSize - 1), [lists:last(Left)|Right]};
        -2 ->
            {[lists:nth(1,Right)|Left], lists:sublist(Right, 2, RightSize -1)};
        _ ->
            {Left, Right}
    end.

median(Left, Right) ->
    LeftSize = length(Left),
    RightSize = length(Right),
    case LeftSize =:= RightSize of
        true ->
            (lists:last(Left) + lists:nth(1,Right)) / 2.0;
        false ->
            lists:last(Left)
    end.