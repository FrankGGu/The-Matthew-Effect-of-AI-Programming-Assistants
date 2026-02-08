-module(solution).
-export([countPalindromes/1]).

countPalindromes(S) ->
    countPalindromes(S, length(S), 0).

countPalindromes(_, 0, Count) -> Count;
countPalindromes(S, N, Count) ->
    NewCount = Count + countPalindromicSubsequences(S, 1, N),
    countPalindromes(S, N - 1, NewCount).

countPalindromicSubsequences(S, Start, End) ->
    case Start > End of
        true -> 0;
        false ->
            if
                Start == End -> 1 + countPalindromicSubsequences(S, Start + 1, End);
                true -> 
                    case lists:nth(Start, S) == lists:nth(End, S) of
                        true -> 
                            1 + countPalindromicSubsequences(S, Start + 1, End) + 
                            countPalindromicSubsequences(S, Start, End - 1);
                        false -> 
                            countPalindromicSubsequences(S, Start + 1, End) + 
                            countPalindromicSubsequences(S, Start, End - 1)
                    end
            end
    end.