-module(solution).
-export([find_special_integer/1]).

find_special_integer(List) ->
    N = length(List),
    Threshold = N div 4,
    find_element(List, Threshold, N).

find_element([], _, _) -> -1;
find_element([H | T], Threshold, N) ->
    Count = count_occurrences(H, [H | T]),
    if
        Count > Threshold -> H;
        true -> find_element(T, Threshold, N)
    end.

count_occurrences(_, []) -> 0;
count_occurrences(X, [H | T]) ->
    Count = count_occurrences(X, T),
    if
        X =:= H -> Count + 1;
        true -> Count
    end.