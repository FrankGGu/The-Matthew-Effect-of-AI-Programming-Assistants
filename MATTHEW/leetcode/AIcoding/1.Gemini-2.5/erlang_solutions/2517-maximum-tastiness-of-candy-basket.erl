-module(solution).
-export([maximum_tastiness/2]).

check(Prices, K, T) ->
    check_recursive(tl(Prices), K - 1, hd(Prices), T).

check_recursive([], Count, _LastChosen, _T) ->
    Count =< 0;
check_recursive([H|T], Count, LastChosen, TVal) ->
    if
        H - LastChosen >= TVal ->
            check_recursive(T, Count - 1, H, TVal);
        true ->
            check_recursive(T, Count, LastChosen, TVal)
    end.

maximum_tastiness(Price, K) ->
    SortedPrices = lists:sort(Price),

    Low = 0,
    High = lists:last(SortedPrices) - hd(SortedPrices),

    binary_search(SortedPrices, K, Low, High, 0).

binary_search(_Prices, _K, Low, High, Ans) when Low > High ->
    Ans;
binary_search(Prices, K, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2,
    if
        check(Prices, K, Mid) ->
            binary_search(Prices, K, Mid + 1, High, Mid);
        true ->
            binary_search(Prices, K, Low, Mid - 1, Ans)
    end.