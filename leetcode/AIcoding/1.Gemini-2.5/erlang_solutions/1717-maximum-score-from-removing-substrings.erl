-module(solution).
-export([maximum_score_from_removing_substrings/3]).

maximum_score_from_removing_substrings(S, X, Y) ->
    if
        X >= Y ->
            {Score1, RemainingStack1} = remove_pairs(S, $a, $b, X),
            RemainingString1 = lists:reverse(RemainingStack1),
            {Score2, _RemainingStack2} = remove_pairs(RemainingString1, $b, $a, Y),
            Score1 + Score2;
        Y > X ->
            {Score1, RemainingStack1} = remove_pairs(S, $b, $a, Y),
            RemainingString1 = lists:reverse(RemainingStack1),
            {Score2, _RemainingStack2} = remove_pairs(RemainingString1, $a, $b, X),
            Score1 + Score2
    end.

remove_pairs(String, Char1, Char2, Points) ->
    remove_pairs_acc(String, Char1, Char2, Points, [], 0).

remove_pairs_acc([], _C1, _C2, _P, Stack, Score) ->
    {Score, Stack};
remove_pairs_acc([H|T], C1, C2, P, [C1|RestStack], Score) when H == C2 ->
    remove_pairs_acc(T, C1, C2, P, RestStack, Score + P);
remove_pairs_acc([H|T], C1, C2, P, Stack, Score) ->
    remove_pairs_acc(T, C1, C2, P, [H|Stack], Score).