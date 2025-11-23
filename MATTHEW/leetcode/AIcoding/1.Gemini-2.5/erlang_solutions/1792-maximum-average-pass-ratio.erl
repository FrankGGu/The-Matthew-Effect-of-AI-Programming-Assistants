-module(solution).
-export([maxAverageRatio/2]).

gain(P, T) ->
    (P+1.0)/(T+1.0) - P/T.

add_students(0, PQ) ->
    PQ;
add_students(N, PQ) when N > 0 ->
    {{NegGain, Id}, {P, T}} = gb_trees:smallest(PQ),
    PQ1 = gb_trees:delete({NegGain, Id}, PQ),
    P_new = P + 1,
    T_new = T + 1,
    NewGain = gain(P_new, T_new),
    PQ2 = gb_trees:insert({-NewGain, Id}, {P_new, T_new}, PQ1),
    add_students(N - 1, PQ2).

maxAverageRatio(Classes, ExtraStudents) ->
    NumClasses = length(Classes),
    {InitialPQ, _} = lists:foldl(
        fun([P, T], {AccPQ, Id}) ->
            CurrentGain = gain(P, T),
            {gb_trees:insert({-CurrentGain, Id}, {P, T}, AccPQ), Id + 1}
        end,
        {gb_trees:empty(), 0},
        Classes
    ),
    FinalPQ = add_students(ExtraStudents, InitialPQ),
    TotalRatioSum = gb_trees:foldl(
        fun(_Key, {P, T}, AccSum) ->
            AccSum + P/T
        end,
        0.0,
        FinalPQ
    ),
    TotalRatioSum / NumClasses.