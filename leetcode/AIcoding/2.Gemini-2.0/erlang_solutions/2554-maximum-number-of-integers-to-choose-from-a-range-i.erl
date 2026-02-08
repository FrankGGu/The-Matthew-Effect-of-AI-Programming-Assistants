-module(maximum_number_integers_to_choose).
-export([max_count/3]).

max_count(Banned, N, MaxSum) ->
    BannedSet = sets:from_list(Banned),
    max_count_helper(1, N, MaxSum, BannedSet, 0).

max_count_helper(Current, N, RemainingSum, BannedSet, Count) when Current > N ->
    Count;
max_count_helper(Current, N, RemainingSum, BannedSet, Count) ->
    case sets:is_element(Current, BannedSet) of
        true ->
            max_count_helper(Current + 1, N, RemainingSum, BannedSet, Count);
        false ->
            case RemainingSum >= Current of
                true ->
                    max_count_helper(Current + 1, N, RemainingSum - Current, BannedSet, Count + 1);
                false ->
                    Count
            end
    end.