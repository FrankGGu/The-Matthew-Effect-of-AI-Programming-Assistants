-module(solution).
-export([maximum_tastiness/2]).

maximum_tastiness(Candies, k) ->
    SortedCandies = lists:sort(Candies),
    MinTaste = 1,
    MaxTaste = hd(SortedCandies) - hd(tl(SortedCandies)),
    search(SortedCandies, MinTaste, MaxTaste, k).

search(_, Low, High, K) when Low > High -> Low - 1;
search(Candies, Low, High, K) ->
    Mid = (Low + High) div 2,
    if
        can_pick(Candies, Mid, K) ->
            search(Candies, Mid + 1, High, K);
        true ->
            search(Candies, Low, Mid - 1, K)
    end.

can_pick(Candies, MinTaste, K) ->
    Count = can_pick_helper(Candies, MinTaste, 0, 0),
    Count >= K.

can_pick_helper([], _, _, _) -> 0;
can_pick_helper([H | T], MinTaste, LastPicked, Count) ->
    if
        H - LastPicked >= MinTaste ->
            can_pick_helper(T, MinTaste, H, Count + 1);
        true ->
            can_pick_helper(T, MinTaste, LastPicked, Count)
    end.