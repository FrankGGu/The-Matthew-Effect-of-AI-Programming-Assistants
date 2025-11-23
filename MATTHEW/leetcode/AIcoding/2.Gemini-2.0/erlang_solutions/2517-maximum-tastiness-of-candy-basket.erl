-module(maximum_tastiness).
-export([maximum_tastiness/2]).

maximum_tastiness(Price, K) ->
    lists:sort(Price, fun(A, B) -> A < B end),
    maximum_tastiness_helper(lists:sort(Price, fun(A, B) -> A < B end), K, 0, lists:last(Price) - lists:nth(1, lists:sort(Price, fun(A, B) -> A < B end))),

maximum_tastiness_helper(Price, K, Low, High) ->
    if Low > High then
        High
    else
        Mid = Low + (High - Low) div 2,
        if is_possible(Price, K, Mid) then
            maximum_tastiness_helper(Price, K, Mid + 1, High)
        else
            maximum_tastiness_helper(Price, K, Low, Mid - 1)
        end
    end.

is_possible(Price, K, Tastiness) ->
    is_possible_helper(Price, K, Tastiness, hd(Price), 1).

is_possible_helper([H|T], K, Tastiness, Last, Count) ->
    if Count >= K then
        true
    else
        is_possible_helper(T, K, Tastiness, Last, Count, H) .
    end;
is_possible_helper([], K, Tastiness, Last, Count) ->
    Count >= K.

is_possible_helper([H|T], K, Tastiness, Last, Count, Curr) ->
    if Curr - Last >= Tastiness then
        is_possible_helper(T, K, Tastiness, Curr, Count + 1)
    else
        is_possible_helper(T, K, Tastiness, Last, Count)
    end;
is_possible_helper([], K, Tastiness, Last, Count, Curr) ->
    Count >= K.