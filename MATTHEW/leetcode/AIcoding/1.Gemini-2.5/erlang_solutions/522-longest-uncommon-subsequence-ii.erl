-module(solution).
-export([findLUSlength/1]).

-spec is_subsequence(string(), string()) -> boolean().
is_subsequence([], _T) -> true;
is_subsequence(_S, []) -> false;
is_subsequence([Sh | St], [Th | Tt]) when Sh == Th ->
    is_subsequence(St, Tt);
is_subsequence(S, [_Th | Tt]) ->
    is_subsequence(S, Tt).

-spec findLUSlength(list(string())) -> integer().
findLUSlength(Strs) ->
    % Create a frequency map of all strings to quickly check for duplicates.
    FreqMap = lists:foldl(
        fun(Str, AccMap) ->
            maps:update_with(Str, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        Strs
    ),

    % Initialize the maximum LUS length found so far to -1 (no LUS found).
    MaxLength = -1,

    % Iterate through each string in the input list to find the longest LUS.
    lists:foldl(
        fun(S, CurrentMaxLength) ->
            % Check the frequency of the current string S.
            case maps:get(S, FreqMap) of
                1 -> % If S appears only once, it's a potential LUS candidate.
                    % Check if S is NOT a subsequence of any OTHER string T in the list.
                    IsLUS = lists:all(
                        fun(T) ->
                            % If T is the same string as S, it's trivially a subsequence of itself,
                            % which doesn't disqualify S as an LUS. So, we allow this case.
                            % If T is different from S, S must NOT be a subsequence of T.
                            S == T orelse not is_subsequence(S, T)
                        end,
                        Strs
                    ),
                    if
                        IsLUS -> % If S is an LUS, update CurrentMaxLength with its length.
                            max(CurrentMaxLength, length(S));
                        true -> % Otherwise, S is not an LUS, keep CurrentMaxLength as is.
                            CurrentMaxLength
                    end;
                _ -> % If S appears more than once, it cannot be an LUS (as it's a subsequence of itself multiple times).
                    CurrentMaxLength
            end
        end,
        MaxLength,
        Strs
    ).