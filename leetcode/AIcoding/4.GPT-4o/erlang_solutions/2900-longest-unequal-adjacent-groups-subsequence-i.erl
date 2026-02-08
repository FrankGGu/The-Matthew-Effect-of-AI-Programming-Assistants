-module(solution).
-export([longest_unequal_adjacent_groups_subsequence_i/1]).

longest_unequal_adjacent_groups_subsequence_i(Nums) ->
    longest_unequal(Nums, 0, 0).

longest_unequal([], Max, _) -> Max;

longest_unequal([H | T], Max, Prev) ->
    case T of
        [] -> max(Max, 1);
        [H2 | _] when H == H2 -> longest_unequal(T, Max, Prev);
        _ -> longest_unequal(T, Max + 1, H)
    end.