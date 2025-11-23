-module(solution).
-export([getMinLength/2]).

-define(INF, 1000000000). % A sufficiently large number for infinity

get_compressed_length(1) -> 1;
get_compressed_length(Count) when Count >= 2 andalso Count <= 9 -> 2;
get_compressed_length(Count) when Count >= 10 andalso Count <= 99 -> 3;
get_compressed_length(Count) when Count == 100 -> 4;
get_compressed_length(_) -> 0. % Should only be called with positive counts or 0 for initial state

getMinLength(S_str, K) ->
    S_list = string:to_list(S_str), % Convert binary string to a list of characters (integers)
    N = length(S_list),
    S_tuple = list_to_tuple(S_list), % Convert list to tuple for O(1) character access

    % Memoization table: maps {Idx, K_rem, LastChar, LastCharCount} to min_len
    % Idx: current index in the string (0 to N)
    % K_rem: remaining deletions allowed (0 to K)
    % LastChar: ASCII value of the last character that was kept in the compressed string (0 for no previous character)
    % LastCharCount: count of the LastChar in the compressed string (0 if no char yet)
    Memo = ets:new(memo_table, [set, protected]),

    % Initial call: start at index 0, with K deletions, no previous char (0), count 0
    solve(S_tuple, N, K, 0, 0, 0, Memo).

solve(S_tuple, N, K_rem, Idx, LastChar, LastCharCount, Memo) ->
    % Base cases
    if
        K_rem < 0 -> ?INF; % Cannot delete more characters than allowed, this path is invalid
        Idx == N -> 0 % Reached the end of the string, no more length to add
    else
        % Check memoization table
        case ets:lookup(Memo, {Idx, K_rem, LastChar, LastCharCount}) of
            [{_, Result}] -> Result; % Return memoized result
            [] ->
                % Get the current character from the tuple (O(1) access)
                Char = element(Idx + 1, S_tuple),

                % Option 1: Delete current character S[Idx]
                % Decrement K_rem, move to the next character.
                % LastChar and LastCharCount remain unchanged as S[Idx] is deleted.
                Res1 = solve(S_tuple, N, K_rem - 1, Idx + 1, LastChar, LastCharCount, Memo),

                % Option 2: Keep current character S[Idx]
                Res2 = if
                    Char == LastChar ->
                        % Current character is the same as the last kept character.
                        % Extend the existing group.
                        OldLen = get_compressed_length(LastCharCount),
                        NewLen = get_compressed_length(LastCharCount + 1),
                        LenChange = NewLen - OldLen, % Change in compressed length due to count increment
                        LenChange + solve(S_tuple, N, K_rem, Idx + 1, LastChar, LastCharCount + 1, Memo);
                    true ->
                        % Current character is different from the last kept character,
                        % or it's the first character in the compressed string.
                        % Start a new group of this character with count 1.
                        LenChange = get_compressed_length(1), % Length for a new group of 1 char (e.g., "a")
                        LenChange + solve(S_tuple, N, K_rem, Idx + 1, Char, 1, Memo)
                end,

                % Store and return the minimum of the two options
                Result = min(Res1, Res2),
                ets:insert(Memo, {{Idx, K_rem, LastChar, LastCharCount}, Result}),
                Result
        end
    end.