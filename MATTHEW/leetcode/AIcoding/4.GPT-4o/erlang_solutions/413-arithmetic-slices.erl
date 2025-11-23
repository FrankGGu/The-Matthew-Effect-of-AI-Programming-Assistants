-module(solution).
-export([number_of_arithmetic_slices/1]).

-spec number_of_arithmetic_slices([integer()]) -> integer().
number_of_arithmetic_slices(Nums) ->
    case length(Nums) >= 3 of
        true -> 
            number_of_slices(Nums, 0, 0);
        false ->
            0
    end.

-spec number_of_slices([integer()], integer(), integer()) -> integer().
number_of_slices([], _, Acc) -> Acc;
number_of_slices([_], _, Acc) -> Acc;
number_of_slices([_, _], _, Acc) -> Acc;
number_of_slices([A, B, C | Rest], Prev_diff, Acc) when B - A == Prev_diff ->
    number_of_slices([B, C | Rest], B - A, Acc + 1);
number_of_slices([A, B, C | Rest], _, Acc) when B - A /= C - B ->
    number_of_slices([B, C | Rest], C - B, Acc);
number_of_slices([A, B, C | Rest], Prev_diff, Acc) ->
    number_of_slices([B, C | Rest], B - A, Acc).
