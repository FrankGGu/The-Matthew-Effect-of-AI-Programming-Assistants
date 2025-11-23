-module(solution).
-export([count_substrings/1]).

count_substrings(S) ->
    count_substrings(S, 0, 0, 0).

count_substrings([], _, _, Count) -> Count;
count_substrings([H | T], Ones, Zeros, Count) ->
    Ones1 = Ones + (if H =:= $1 -> 1; true -> 0 end),
    Zeros1 = Zeros + (if H =:= $0 -> 1; true -> 0 end),
    DominantCount = dominant_count(Ones1, Zeros1),
    Count1 = Count + DominantCount,
    count_substrings(T, Ones1, Zeros1, Count1).

dominant_count(Ones, Zeros) ->
    if Ones > Zeros -> Ones - Zeros; true -> 0 end.