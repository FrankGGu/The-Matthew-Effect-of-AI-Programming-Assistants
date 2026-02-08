-module(solution).
-export([number_of_weak_characters/1]).

number_of_weak_characters(Props) ->
    SortedProps = lists:sort(fun({A1, D1}, {A2, D2}) -> 
        case A1 <=> A2 of
            GT -> true;
            EQ -> D1 > D2;
            LT -> false
        end
    end, Props),
    count_weak(SortedProps, 0, 0).

count_weak([], _, Count) -> Count;
count_weak([{A, D} | Rest], MaxDefense, Count) ->
    NewCount = if D < MaxDefense -> Count + 1; true -> Count end,
    count_weak(Rest, max(MaxDefense, D), NewCount).