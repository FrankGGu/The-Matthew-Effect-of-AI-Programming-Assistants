-module(solution).
-export([longestPalindrome/2]).

get_char_bin(Bin, Idx) ->
    binary:at(Bin, Idx).

lps(S_list) ->
    S = list_to_binary(S_list), % Convert to binary for O(1) character access
    N = byte_size(S),
    if N == 0 -> 0;
       N == 1 -> 1;
       true ->
            % DP table: map where keys are {I, J} and values are lengths
            % Initialize with base cases for length 1 subsequences
            DP0 = lists:foldl(fun(I, Acc) ->
                                      maps:put({I, I}, 1, Acc)
                              end, maps:new(), lists:seq(0, N-1)),

            % Fill DP table for lengths from 2 to N
            FinalDP = lists:foldl(fun(Len, Acc1) ->
                                    lists:foldl(fun(I, Acc2) ->
                                        J = I + Len - 1,
                                        if J >= N -> Acc2; % Ensure J is within bounds
                                           true ->
                                                CharI = get_char_bin(S, I),
                                                CharJ = get_char_bin(S, J),
                                                Val = if CharI == CharJ ->
                                                            % If characters match, add 2 to LPS of inner substring
                                                            % If Len == 2, inner is empty, so 2.
                                                            % Otherwise, get from {I+1, J-1}
                                                            InnerLen = if Len == 2 -> 0;
                                                                        true -> maps:get({I+1, J-1}, Acc2)
                                                                       end,
                                                            2 + InnerLen;
                                                        true ->
                                                            % If characters don't match, take max of removing S[i] or S[j]
                                                            MaxLeft = maps:get({I+1, J}, Acc2),
                                                            MaxRight = maps:get({I, J-1}, Acc2),
                                                            max(MaxLeft, MaxRight)
                                                      end,
                                                maps:put({I, J}, Val, Acc2)
                                        end
                                    end, Acc1, lists:seq(0, N-1))
                            end, DP0, lists:seq(2, N)),
            maps:get({0, N-1}, FinalDP)
    end.

lcs(S1_list, S2_list) ->
    S1 = list_to_binary(S1_list), % Convert to binary for O(1) character access
    S2 = list_to_binary(S2_list), % Convert to binary for O(1) character access
    N1 = byte_size(S1),
    N2 = byte_size(S2),
    if N1 == 0; N2 == 0 -> 0;
       true ->
            % DP table: map where keys are {I, J} and values are lengths
            % dp[i][j] stores LCS length for S1[0...i-1] and S2[0...j-1]
            % Initialize with 0s for empty prefixes (I=0 or J=0)
            DP0 = maps:new(),
            DP1 = lists:foldl(fun(I, Acc) -> maps:put({I, 0}, 0, Acc) end, DP0, lists:seq(0, N1)),
            DP2 = lists:foldl(fun(J, Acc) -> maps:put({0, J}, 0, Acc) end, DP1, lists:seq(0, N2)),

            % Fill DP table
            FinalDP = lists:foldl(fun(I, Acc1) ->
                                    lists:foldl(fun(J, Acc2) ->
                                        CharI = get_char_bin(S1, I-1), % S1[I-1]
                                        CharJ = get_char_bin(S2, J-1), % S2[J-1]
                                        Val = if CharI == CharJ ->
                                                    maps:get({I-1, J-1}, Acc2) + 1;
                                                true ->
                                                    max(maps:get({I-1, J}, Acc2), maps:get({I, J-1}, Acc2))
                                              end,
                                        maps:put({I, J}, Val, Acc2)
                                    end, Acc1, lists:seq(1, N2))
                            end, DP2, lists:seq(1, N1)),
            maps:get({N1, N2}, FinalDP)
    end.

longestPalindrome(Word1, Word2) ->
    % Case 1: Palindrome entirely from Word1
    LPS1 = lps(Word1),

    % Case 2: Palindrome entirely from Word2
    LPS2 = lps(Word2),

    % Case 3: Palindrome formed by subsequence1 from Word1 and subsequence2 from Word2
    % where subsequence1 = reverse(subsequence2)
    % This is equivalent to 2 * LCS(Word1, reverse(Word2))
    ReversedWord2 = lists:reverse(Word2),
    LCS_Val = lcs(Word1, ReversedWord2),
    LCS_Palindrome_Length = 2 * LCS_Val,

    % Max of all three cases
    max(LPS1, max(LPS2, LCS_Palindrome_Length)).