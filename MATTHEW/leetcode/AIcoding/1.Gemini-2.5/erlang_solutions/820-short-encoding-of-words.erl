-module(solution).
-export([minimum_length_encoding/1]).

minimum_length_encoding(Words) ->
    % 1. Create a set of all unique words from the input list.
    % This set will initially contain all words that are candidates for the encoding.
    CandidateWords = sets:from_list(Words),

    % 2. Iterate through each word in the original input list.
    % 3. For each word, generate all its proper suffixes (i.e., suffixes that are shorter than the word itself).
    % 4. If any of these proper suffixes exist in our CandidateWords set, it means that suffix is already
    %    covered by a longer word (the current word), so we remove it from the CandidateWords set.
    FinalCandidateWords = lists:foldl(
        fun(Word, AccSet) ->
            WordLen = length(Word),
            % Generate proper suffixes by taking `lists:nthtail(N, Word)` for N from 1 to WordLen - 1.
            % For example, if Word = "time", WordLen = 4.
            % N=1 -> "ime"
            % N=2 -> "me"
            % N=3 -> "e"
            lists:foldl(
                fun(Idx, CurrentSet) ->
                    Suffix = lists:nthtail(Idx, Word),
                    % If the suffix is in the set, it means it's covered by a longer word,
                    % so we remove it from the set of words that need to be explicitly encoded.
                    if
                        sets:is_element(Suffix, CurrentSet) ->
                            sets:delete(Suffix, CurrentSet);
                        true ->
                            CurrentSet
                    end
                end,
                AccSet,
                % Generate indices for proper suffixes. A word of length L has L-1 proper suffixes.
                % If WordLen is 1 (e.g., "a"), then lists:seq(1, 0) returns [], so no suffixes are generated.
                lists:seq(1, WordLen - 1)
            )
        end,
        CandidateWords, % Initial accumulator for the outer fold is the set of all unique words.
        Words
    ),

    % 5. After processing all words and removing their covered suffixes,
    %    the remaining words in FinalCandidateWords are the ones that must be explicitly encoded.
    % 6. Calculate the total length: sum of (length of each word + 1 for the '#' delimiter).
    sets:fold(
        fun(Word, AccSum) ->
            AccSum + length(Word) + 1
        end,
        0, % Initial sum is 0.
        FinalCandidateWords
    ).