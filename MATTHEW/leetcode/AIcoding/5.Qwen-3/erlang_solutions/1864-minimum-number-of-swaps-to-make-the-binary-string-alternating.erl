-module(min_swaps).
-export([min_swaps/1]).

min_swaps(Str) ->
    Len = length(Str),
    Even = count_diff(Str, 0),
    Odd = count_diff(Str, 1),
    case Len rem 2 of
        0 -> min(Even, Odd);
        _ -> if Even == Odd -> Even; true -> min(Even, Odd) end
    end.

count_diff([], _), -> 0;
count_diff([H|T], Expected) ->
    Current = H - $0,
    if Current == Expected -> count_diff(T, Expected);
       true -> 1 + count_diff(T, Expected)
    end.

min(A, B) when A < B -> A;
min(_, B) -> B.