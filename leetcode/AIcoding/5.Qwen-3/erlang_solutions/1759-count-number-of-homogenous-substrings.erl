-module(solution).
-export([count_homogenous_substrings/1]).

count_homogenous_substrings(S) ->
    count_homogenous_substrings(S, 0, 0, 0).

count_homogenous_substrings([], _, _, Acc) ->
    Acc;
count_homogenous_substrings([C | T], PrevChar, Count, Acc) ->
    if
        C == PrevChar ->
            NewCount = Count + 1,
            NewAcc = Acc + NewCount,
            count_homogenous_substrings(T, C, NewCount, NewAcc);
        true ->
            count_homogenous_substrings(T, C, 1, Acc + 1)
    end.