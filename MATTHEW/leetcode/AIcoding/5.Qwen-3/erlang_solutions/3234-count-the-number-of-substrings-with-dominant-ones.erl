-module(solution).
-export([number_of_substrings/1]).

number_of_substrings(S) ->
    N = length(S),
    Count = 0,
    Count = count_substrings(S, N, 0, 0, 0),
    Count.

count_substrings(_, _, _, _, R) when R >= 2 -> 0;
count_substrings([], _, _, _, _) -> 0;
count_substrings([H | T], N, L, Ones, R) ->
    case H of
        $1 ->
            Ones1 = Ones + 1,
            R1 = R + 1,
            count_substrings(T, N, L, Ones1, R1);
        _ ->
            count_substrings(T, N, L, 0, 0)
    end.