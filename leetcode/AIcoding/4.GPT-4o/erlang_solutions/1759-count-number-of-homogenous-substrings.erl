-module(solution).
-export([count_homogenous_substrings/1]).

count_homogenous_substrings(Str) ->
    count_homogenous_substrings(Str, 0, 0).

count_homogenous_substrings([], Count, Acc) ->
    Acc;
count_homogenous_substrings([H | T], Count, Acc) ->
    NewCount = case Count of
        0 -> 1;
        _ when H =:= hd(T) -> Count + 1;
        _ -> 1
    end,
    count_homogenous_substrings(T, NewCount, Acc + NewCount).