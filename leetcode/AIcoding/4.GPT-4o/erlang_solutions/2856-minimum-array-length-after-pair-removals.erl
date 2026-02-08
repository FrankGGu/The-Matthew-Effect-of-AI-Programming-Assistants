-module(solution).
-export([minimum_array_length/1]).

minimum_array_length(List) ->
    Sorted = lists:sort(List),
    MinimumLength = minimum_length(Sorted, 0, length(Sorted)),
    MinimumLength.

minimum_length([], Count, Count) -> Count;
minimum_length([H | T], Count, Length) ->
    case T of
        [] -> Length;
        [H2 | _] when H == H2 -> minimum_length(T, Count + 2, Length - 2);
        _ -> minimum_length(T, Count, Length)
    end.