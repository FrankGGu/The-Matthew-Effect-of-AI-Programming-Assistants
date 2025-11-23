-module(solution).
-export([minAbsDifference/2]).

minAbsDifference(Nums, Goal) ->
    Len = length(Nums),
    Mid = Len div 2,

    L1 = lists:sublist(Nums, Mid),
    L2 = lists:nthtail(Mid, Nums),

    Sums1 = generate_sums(L1),
    Sums2 = generate_sums(L2),

    SortedSums1 = lists:sort(Sums1),
    SortedSums2Rev = lists:reverse(lists:sort(Sums2)),

    InitialMinDiff = abs(Goal),

    two_pointer_search(SortedSums1, SortedSums2Rev, Goal, InitialMinDiff).

generate_sums(List) ->
    lists:foldl(
        fun(X, Acc) ->
            Acc ++ [X + S || S <- Acc]
        end,
        [0],
        List
    ).

two_pointer_search(S1List, S2List, Goal, MinDiff) ->
    case {S1List, S2List} of
        {[], _} -> MinDiff;
        {_, []} -> MinDiff;
        {[S1H|S1T], [S2H|S2T]} ->
            CurrentSum = S1H + S2H,
            NewMinDiff = min(MinDiff, abs(CurrentSum - Goal)),

            if
                CurrentSum < Goal ->
                    two_pointer_search(S1T, [S2H|S2T], Goal, NewMinDiff);
                CurrentSum > Goal ->
                    two_pointer_search([S1H|S1T], S2T, Goal, NewMinDiff);
                true ->
                    0
            end
    end.