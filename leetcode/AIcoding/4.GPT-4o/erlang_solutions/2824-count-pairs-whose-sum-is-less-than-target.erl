-module(solution).
-export([count_pairs/2]).

count_pairs(List, Target) ->
    Sorted = lists:sort(List),
    count_pairs_helper(Sorted, Target, 0, 0).

count_pairs_helper(List, Target, Left, Count) when Left < length(List) ->
    case lists:nth(Left + 1, List) of
        X when X < Target - lists:nth(Left, List) ->
            count_pairs_helper(List, Target, Left + 1, Count + (length(List) - Left - 1));
        _ ->
            count_pairs_helper(List, Target, Left + 1, Count)
    end;
count_pairs_helper(_, _, _, Count) ->
    Count.