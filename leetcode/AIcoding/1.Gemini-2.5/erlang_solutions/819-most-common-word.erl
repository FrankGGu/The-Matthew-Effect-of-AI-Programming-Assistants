-module(solution).
-export([most_common_word/2]).

most_common_word(Paragraph, Banned) ->
    % 1. Normalize paragraph: replace punctuation with spaces, convert to lowercase, split into words.
    %    The regex matches any of the specified punctuation characters.
    NormalizedParagraph = re:replace(Paragraph, "[!?',;.]", " ", [{return, list}, global]),
    LowercasedParagraph = string:to_lower(NormalizedParagraph),
    Words = string:tokens(LowercasedParagraph, " "),

    % 2. Create a set of banned words for efficient lookup (O(1) average for is_element).
    BannedSet = sets:from_list(Banned),

    % 3. Filter out empty strings (result of multiple spaces or leading/trailing spaces)
    %    and words that are in the banned set.
    ValidWords = lists:filter(fun(Word) ->
                                  Word /= "" andalso not sets:is_element(Word, BannedSet)
                              end, Words),

    % 4. Count word frequencies using a map.
    %    maps:update_with(Key, UpdateFun, InsertValue, Map) updates an existing key
    %    or inserts it with InsertValue if not present.
    FreqMap = lists:foldl(fun(Word, AccMap) ->
                              maps:update_with(Word, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, #{}, ValidWords),

    % 5. Find the most frequent word.
    %    The problem guarantees at least one non-banned word and a unique most frequent word.
    %    Convert map to a list of {Word, Count} tuples and find the one with the maximum count.
    case maps:to_list(FreqMap) of
        [] ->
            % This case should not be reached based on problem constraints (at least one valid word).
            ""; 
        [FirstWordCount | RestWordCounts] ->
            {MostCommon, _MaxCount} = lists:foldl(fun({Word, Count}, {CurrentMostCommon, CurrentMaxCount}) ->
                                                      if Count > CurrentMaxCount -> {Word, Count};
                                                         true -> {CurrentMostCommon, CurrentMaxCount}
                                                      end
                                                  end, FirstWordCount, RestWordCounts),
            MostCommon
    end.