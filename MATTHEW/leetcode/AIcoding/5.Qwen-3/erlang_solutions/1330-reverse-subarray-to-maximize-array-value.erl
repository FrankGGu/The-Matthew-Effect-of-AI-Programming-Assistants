-module(solution).
-export([maxValueAfterReverse/1]).

maxValueAfterReverse(A) ->
    N = length(A),
    Max = 0,
    {Max, _} = lists:foldl(fun(I, {Acc, Prev}) ->
        if
            I == 0 -> {Acc, A#{}};
            true ->
                Diff = abs(A#{I} - A#{I-1}),
                NewAcc = Acc + Diff,
                {NewAcc, A#{I}}
        end
    end, {0, A}, lists:seq(0, N-1)),
    {Best, _} = lists:foldl(fun(I, {BestSoFar, Prev}) ->
        if
            I == 0 -> {BestSoFar, A#{I}};
            true ->
                Diff = abs(A#{I} - A#{I-1}),
                NewBest = BestSoFar + Diff,
                {NewBest, A#{I}}
        end
    end, {0, A}, lists:seq(0, N-1)),
    Best.