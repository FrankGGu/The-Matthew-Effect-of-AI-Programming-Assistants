-module(solution).
-export([longestPalindrome/1]).

longestPalindrome(Words) ->
    InitialFreqMap = lists:foldl(fun(Word, Acc) ->
                                         maps:update_with(Word, fun(Count) -> Count + 1 end, 1, Acc)
                                 end, #{}, Words),

    longest_palindrome_helper(maps:to_list(InitialFreqMap), 0, false, InitialFreqMap).

longest_palindrome_helper([], CurrentLength, HasCenter, _FreqMap) ->
    if HasCenter -> CurrentLength + 2;
       true -> CurrentLength
    end;
longest_palindrome_helper([{Word, Count} | Rest], CurrentLength, HasCenter, FreqMap) ->
    if Count == 0 ->
            longest_palindrome_helper(Rest, CurrentLength, HasCenter, FreqMap);
       true ->
            Char1 = binary:at(Word, 0),
            Char2 = binary:at(Word, 1),
            if Char1 == Char2 -> % Palindromic word like "aa"
                    Pairs = Count div 2,
                    NewLength = CurrentLength + 4 * Pairs,
                    NewHasCenter = HasCenter or (Count rem 2 == 1),
                    UpdatedFreqMap = maps:put(Word, 0, FreqMap), % Mark this word as fully used
                    longest_palindrome_helper(Rest, NewLength, NewHasCenter, UpdatedFreqMap);
               true -> % Non-palindromic word like "ab"
                    RevWord = <<Char2, Char1>>,
                    RevCount = maps:get(RevWord, FreqMap, 0),
                    if RevCount > 0 ->
                            % To avoid double counting (e.g., "ab" and "ba"),
                            % we only process the pair when Word is lexicographically smaller than RevWord.
                            % If Word == RevWord, it's handled by the Char1 == Char2 case.
                            if Word < RevWord ->
                                    MinPairs = min(Count, RevCount),
                                    NewLength = CurrentLength + 4 * MinPairs,
                                    UpdatedFreqMap1 = maps:put(Word, Count - MinPairs, FreqMap),
                                    UpdatedFreqMap2 = maps:put(RevWord, RevCount - MinPairs, UpdatedFreqMap1),
                                    longest_palindrome_helper(Rest, NewLength, HasCenter, UpdatedFreqMap2);
                               true -> % Word > RevWord, it will be processed when RevWord is encountered
                                    longest_palindrome_helper(Rest, CurrentLength, HasCenter, FreqMap)
                            end;
                       true -> % RevWord not found or count is 0, this word cannot form a pair
                            longest_palindrome_helper(Rest, CurrentLength, HasCenter, FreqMap)
                    end
            end
    end.