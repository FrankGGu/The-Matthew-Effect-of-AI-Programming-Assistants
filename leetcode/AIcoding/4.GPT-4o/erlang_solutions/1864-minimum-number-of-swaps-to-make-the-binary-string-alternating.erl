-module(solution).
-export([min_swaps/1]).

min_swaps(BinaryString) ->
    Count0 = count_swaps(BinaryString, '0'),
    Count1 = count_swaps(BinaryString, '1'),
    min(Count0, Count1).

count_swaps([], _) -> 0;
count_swaps([H | T], Type) ->
    case H == Type of
        true -> count_swaps(T, Type);
        false -> 1 + count_swaps(T, Type)
    end.