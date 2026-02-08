-module(solution).
-export([count_substrings/2]).

count_substrings(S, T) ->
    count_substrings(S, T, 0).

count_substrings([], [], Acc) -> Acc;
count_substrings([H1 | T1], [H2 | T2], Acc) ->
    count_substrings(T1, T2, Acc + count_differences(H1, H2, 1));
count_substrings(_, _, Acc) -> Acc.

count_differences([], [], _) -> 0;
count_differences([H1 | T1], [H2 | T2], D) ->
    case H1 =:= H2 of
        true -> count_differences(T1, T2, D);
        false -> count_differences(T1, T2, D - 1) + 1
    end.