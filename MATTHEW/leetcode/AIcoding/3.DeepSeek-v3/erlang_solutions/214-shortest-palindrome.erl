-module(solution).
-export([shortest_palindrome/1]).

shortest_palindrome(S) ->
    case S of
        "" -> "";
        _ ->
            RevS = lists:reverse(S),
            L = length(S),
            Max = find_max_palindrome(S, RevS, L),
            string:slice(RevS, 0, L - Max) ++ S
    end.

find_max_palindrome(S, RevS, L) ->
    find_max_palindrome(S, RevS, L, 0, 0, 0).

find_max_palindrome(S, RevS, L, I, J, Max) when I < L andalso J < L ->
    case lists:nth(I + 1, S) =:= lists:nth(J + 1, RevS) of
        true ->
            NewMax = if
                I + 1 > Max -> I + 1;
                true -> Max
            end,
            find_max_palindrome(S, RevS, L, I + 1, J + 1, NewMax);
        false ->
            if
                I =:= 0 -> find_max_palindrome(S, RevS, L, I, J + 1, Max);
                true -> find_max_palindrome(S, RevS, L, 0, J - I + 1, Max)
            end
    end;
find_max_palindrome(_, _, _, _, _, Max) ->
    Max.