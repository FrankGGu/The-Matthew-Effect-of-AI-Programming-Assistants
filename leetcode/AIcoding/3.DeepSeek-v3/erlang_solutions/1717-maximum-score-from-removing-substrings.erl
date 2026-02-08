-module(solution).
-export([maximumGain/2]).

maximumGain(S, X, Y) ->
    {A, B, ScoreA, ScoreB} = if X > Y -> {$a, $b, X, Y}; true -> {$b, $a, Y, X} end,
    {FirstScore, FirstRemaining} = remove_pairs(S, A, B, ScoreA),
    {SecondScore, _} = remove_pairs(FirstRemaining, B, A, ScoreB),
    FirstScore + SecondScore.

remove_pairs(S, A, B, Score) ->
    remove_pairs(S, A, B, Score, [], 0).

remove_pairs([], _, _, _, Stack, Score) ->
    {Score, lists:reverse(Stack)};
remove_pairs([C | Rest], A, B, Score, Stack, Total) ->
    case Stack of
        [A | StackRest] when C =:= B ->
            remove_pairs(Rest, A, B, Score, StackRest, Total + Score);
        _ ->
            remove_pairs(Rest, A, B, Score, [C | Stack], Total)
    end.