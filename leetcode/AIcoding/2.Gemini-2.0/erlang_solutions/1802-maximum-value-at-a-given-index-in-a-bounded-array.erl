-module(maximum_value).
-export([max_value/3]).

max_value(N, Index, MaxSum) ->
    binary_search(1, MaxSum, N, Index, MaxSum).

binary_search(Low, High, N, Index, MaxSum) ->
    if Low > High ->
        High;
    true ->
        Mid = Low + (High - Low) div 2,
        Sum = calculate_sum(Mid, N, Index),
        if Sum =< MaxSum ->
            binary_search(Mid + 1, High, N, Index, MaxSum);
        true ->
            binary_search(Low, Mid - 1, N, Index, MaxSum)
    end.

calculate_sum(Value, N, Index) ->
    LeftSum = calculate_side_sum(Value, Index + 1),
    RightSum = calculate_side_sum(Value, N - Index),
    LeftSum + RightSum - Value.

calculate_side_sum(Value, Length) ->
    if Value >= Length ->
        (Value + Value - Length + 1) * Length div 2;
    true ->
        (Value + 1) * Value div 2 + (Length - Value)
    end.