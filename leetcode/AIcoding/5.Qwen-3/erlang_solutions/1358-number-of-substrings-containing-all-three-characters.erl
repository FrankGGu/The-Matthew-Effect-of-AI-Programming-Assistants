-module(solution).
-export([number_of_substrings/1]).

number_of_substrings(S) ->
    N = erlang:length(S),
    Count = 0,
    A = 0,
    B = 0,
    C = 0,
    Left = 0,
    number_of_substrings(S, N, Count, A, B, C, Left).

number_of_substrings(_, N, Count, A, B, C, Left) when Left >= N ->
    Count;
number_of_substrings(S, N, Count, A, B, C, Left) ->
    Char = lists:nth(Left + 1, S),
    case Char of
        $a -> NewA = A + 1, NewB = B, NewC = C;
        $b -> NewA = A, NewB = B + 1, NewC = C;
        $c -> NewA = A, NewB = B, NewC = C + 1
    end,
    if
        NewA > 0 andalso NewB > 0 andalso NewC > 0 ->
            Count2 = Count + (N - Left),
            number_of_substrings(S, N, Count2, NewA, NewB, NewC, Left + 1);
        true ->
            number_of_substrings(S, N, Count, NewA, NewB, NewC, Left + 1)
    end.