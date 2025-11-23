-module(buddy_strings).
-export([buddyStrings/2]).

buddyStrings(S, Goal) ->
    LenS = length(S),
    LenGoal = length(Goal),

    if LenS =/= LenGoal ->
        false;
    true ->
        DiffPairs = [{CharS, CharGoal} || {CharS, CharGoal} <- lists:zip(S, Goal), CharS =/= CharGoal],
        NumDiffs = length(DiffPairs),

        if NumDiffs == 0 ->
            has_duplicates(S, gb_sets:new());
        NumDiffs == 2 ->
            [{S1, G1}, {S2, G2}] = DiffPairs,
            (S1 == G2) and (S2 == G1);
        true ->
            false
        end
    end.

has_duplicates([], _Seen) ->
    false;
has_duplicates([H|T], Seen) ->
    if gb_sets:is_member(H, Seen) ->
        true;
    true ->
        has_duplicates(T, gb_sets:add(H, Seen))
    end.