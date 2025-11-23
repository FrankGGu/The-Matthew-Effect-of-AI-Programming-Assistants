-module(solution).
-export([count_monotonic_pairs/1]).

count_monotonic_pairs(Nums) ->
    count_monotonic_pairs(Nums, 0, 0).

count_monotonic_pairs([], _, Count) ->
    Count;
count_monotonic_pairs([_], _, Count) ->
    Count;
count_monotonic_pairs([A, B | Rest], Index, Count) ->
    case A =< B of
        true ->
            count_monotonic_pairs([B | Rest], Index + 1, Count + 1);
        false ->
            count_monotonic_pairs([B | Rest], Index + 1, Count)
    end.