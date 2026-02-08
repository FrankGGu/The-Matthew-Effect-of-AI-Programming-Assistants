-module(solution).
-export([findBestValue/2]).

findBestValue(Arr, Target) ->
    Sorted = lists:sort(Arr),
    Prefix = prefix_sum(Sorted),
    find_best_value(Sorted, Prefix, Target, 0, lists:last(Sorted)).

prefix_sum(List) ->
    prefix_sum(List, 0, []).

prefix_sum([], _, Acc) ->
    lists:reverse(Acc);
prefix_sum([H|T], Sum, Acc) ->
    NewSum = Sum + H,
    prefix_sum(T, NewSum, [NewSum|Acc]).

find_best_value(Sorted, Prefix, Target, Left, Right) ->
    if
        Left >= Right ->
            Left;
        true ->
            Mid = (Left + Right) div 2,
            Sum = calculate_sum(Sorted, Prefix, Mid),
            if
                Sum < Target ->
                    find_best_value(Sorted, Prefix, Target, Mid + 1, Right);
                true ->
                    find_best_value(Sorted, Prefix, Target, Left, Mid)
            end
    end.

calculate_sum(Sorted, Prefix, Value) ->
    Index = find_first_larger(Sorted, Value),
    case Index of
        0 ->
            length(Sorted) * Value;
        _ ->
            lists:nth(Index, Prefix) + (length(Sorted) - Index) * Value
    end.

find_first_larger(List, Value) ->
    find_first_larger(List, Value, 0, length(List)).

find_first_larger(List, Value, Low, High) ->
    if
        Low >= High ->
            Low;
        true ->
            Mid = (Low + High) div 2,
            case lists:nth(Mid + 1, List) of
                Elem when Elem > Value ->
                    find_first_larger(List, Value, Low, Mid);
                _ ->
                    find_first_larger(List, Value, Mid + 1, High)
            end
    end.