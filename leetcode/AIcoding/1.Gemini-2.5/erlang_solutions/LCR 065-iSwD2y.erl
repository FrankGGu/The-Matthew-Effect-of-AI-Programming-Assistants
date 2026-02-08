-module(solution).
-export([solve/1]).

solve(Words) ->
    InitialWordSet = gb_sets:from_list(Words),

    % CurrentWordSet will hold the words that are not suffixes of any other word
    % in the original list.
    CurrentWordSet = lists:foldl(
        fun(Word, AccSet) ->
            WordLen = length(Word),
            % Iterate through all proper suffixes of the current Word
            lists:foldl(
                fun(I, InnerAccSet) ->
                    Suffix = lists:nthtail(I, Word),
                    % If this suffix exists in the original set of words,
                    % it means 'Word' covers 'Suffix', so 'Suffix' can be removed
                    % from the set of words we need to keep.
                    case gb_sets:is_member(Suffix, InitialWordSet) of
                        true -> gb_sets:delete(Suffix, InnerAccSet);
                        false -> InnerAccSet
                    end
                end,
                AccSet,
                lists:seq(1, WordLen - 1) % Generate indices for proper suffixes (e.g., "time" -> "ime", "me", "e")
            )
        end,
        InitialWordSet, % Start with all unique words, and remove covered ones
        gb_sets:to_list(InitialWordSet) % Iterate over each unique word from the original input
    ),

    % The total length is the sum of (length of word + 1 for '#') for all
    % words that are not suffixes of any other word.
    lists:sum([length(W) + 1 || W <- gb_sets:to_list(CurrentWordSet)]).