-module(solution).
-export([smallest_substring_with_identical_characters_ii/1]).

smallest_substring_with_identical_characters_ii(S) ->
    N = length(S),
    if N < 4 -> -1; % Smallest possible L is 2, so smallest length is 2*2 = 4
       true -> solve(S, N)
    end.

solve(S, N) ->
    % Precompute LenRight: length of identical char block starting at index i
    % LenRight[i] = Length of block of S[i] starting at i
    % Example: "aaabccde" -> [3,2,1,1,2,1,1,1]
    LenRight = compute_len_right(S),

    CharMaxLenMap = maps:new(),
    MinOverallLen = infinity,

    find_min_len(0, S, N, LenRight, CharMaxLenMap, MinOverallLen).

find_min_len(I, S, N, LenRight, CharMaxLenMap, MinOverallLen) when I < N ->
    Char = lists:nth(I + 1, S), % Erlang lists are 1-indexed
    CurrentBlockLen = lists:nth(I + 1, LenRight),

    if CurrentBlockLen < 2 ->
        % Skip blocks with length less than 2, as L must be >= 2
        NextI = I + CurrentBlockLen,
        find_min_len(NextI, S, N, LenRight, CharMaxLenMap, MinOverallLen);
    true ->
        OldMaxLForChar = maps:get(Char, CharMaxLenMap, 0),

        NewMinOverallLen = 
            if CurrentBlockLen > OldMaxLForChar ->
                % If this block is longer than any previously seen block for this char,
                % check against all other chars' max_L to find potential new minimums.
                lists:foldl(
                    fun(KVPair, AccMinLen) ->
                        {OtherChar, OtherMaxL} = KVPair,
                        if OtherChar /= Char andalso OtherMaxL >= 2 ->
                            L = min(CurrentBlockLen, OtherMaxL),
                            min(AccMinLen, 2 * L);
                        true ->
                            AccMinLen
                        end
                    end,
                    MinOverallLen,
                    maps:to_list(CharMaxLenMap)
                );
            true ->
                % This block is not longer than already seen max_L for this char,
                % so it won't yield a smaller L for any (char, other_char) pair
                % than what was already considered when OldMaxLForChar was set.
                MinOverallLen
            end,

        NewCharMaxLenMap = maps:put(Char, CurrentBlockLen, CharMaxLenMap),
        NextI = I + CurrentBlockLen,
        find_min_len(NextI, S, N, LenRight, NewCharMaxLenMap, NewMinOverallLen)
    end;
find_min_len(_I, _S, _N, _LenRight, _CharMaxLenMap, MinOverallLen) ->
    if MinOverallLen == infinity -> -1;
       true -> MinOverallLen
    end.

compute_len_right(S) ->
    % S is a list of characters
    % Returns a list of integers, where element at index i (0-indexed)
    % is the length of the identical char block starting at S[i].
    % Example: "aaabccde" -> [3,2,1,1,2,1,1,1]
    {_LastChar, _LastLen, Result} = lists:foldr(
        fun(Char, {PrevChar, PrevLen, Acc}) ->
            Len = if Char == PrevChar -> PrevLen + 1; true -> 1 end,
            {Char, Len, [Len | Acc]}
        end,
        {nil, 0, []}, % Initial state: no previous char, length 0, empty accumulator
        S
    ),
    Result.

-define(infinity, 1000000000). % A sufficiently large number