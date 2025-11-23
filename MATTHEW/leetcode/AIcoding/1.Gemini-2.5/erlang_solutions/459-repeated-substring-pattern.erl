-module(repeated_substring_pattern).
-export([repeatedSubstringPattern/1]).

repeatedSubstringPattern(S) ->
    N = string:len(S),
    if
        N =< 1 -> false;
        true ->
            % Create S+S
            S_double = S ++ S,
            % Remove the first and last characters from S_double
            % The substring starts at index 2 (1-based)
            % The length is (2 * N) - 2
            S_shifted = string:substr(S_double, 2, N*2 - 2),
            % Check if the original string S is a substring of S_shifted
            % If it is, then S can be formed by repeating a substring.
            string:str(S_shifted, S) /= 0
    end.