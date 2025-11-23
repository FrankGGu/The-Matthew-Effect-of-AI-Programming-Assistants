-module(solution).
-export([maximumTastiness/2]).

maximumTastiness(Price, K) ->
    SortedPrice = lists:sort(Price),
    MinPrice = hd(SortedPrice),
    MaxPrice = lists:last(SortedPrice),

    Low = 0,
    High = MaxPrice - MinPrice,

    binary_search(Low, High, SortedPrice, K, 0).

binary_search(Low, High, SortedPrice, K, CurrentAns) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case check(Mid, SortedPrice, K) of
        true ->
            binary_search(Mid + 1, High, SortedPrice, K, Mid);
        false ->
            binary_search(Low, Mid - 1, SortedPrice, K, CurrentAns)
    end;
binary_search(_, _, _, _, CurrentAns) ->
    CurrentAns.

check(X, SortedPrice, K) ->
    Count = 1,
    LastPickedPrice = hd(SortedPrice),

    check_iter(tl(SortedPrice), X, K, Count, LastPickedPrice).

check_iter([], _, _, CurrentCount, _) ->
    CurrentCount >= K;
check_iter([H|T], X, K, CurrentCount, LastPickedPrice) ->
    if
        H - LastPickedPrice >= X ->
            NewCount = CurrentCount + 1,
            if
                NewCount >= K ->
                    true;
                true ->
                    check_iter(T, X, K, NewCount, H)
            end;
        true ->
            check_iter(T, X, K, CurrentCount, LastPickedPrice)
    end.