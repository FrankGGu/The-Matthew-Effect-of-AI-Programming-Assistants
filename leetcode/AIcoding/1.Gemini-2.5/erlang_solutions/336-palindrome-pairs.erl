-module(solution).
-export([palindromePairs/1]).

palindromePairs(Words) ->
    WordsMap = build_words_map(Words),
    Results1 = handle_empty_string(Words, WordsMap, []),
    FinalResults = lists:foldl(fun({Word, Idx}, Acc) ->
                                   process_word(Word, Idx, WordsMap, Acc)
                               end, Results1, lists:zip(Words, lists:seq(0, length(Words) - 1))),
    lists:usort(FinalResults).

build_words_map(Words) ->
    maps:from_list(lists:zip(Words, lists:seq(0, length(Words) - 1))).

is_palindrome(Str) ->
    Str == lists:reverse(Str).

handle_empty_string(Words, WordsMap, Acc) ->
    case maps:is_key("", WordsMap) of
        true ->
            EmptyIdx = maps:get("", WordsMap),
            lists:foldl(fun({Word, Idx}, CurrentAcc) ->
                            if Idx == EmptyIdx -> CurrentAcc;
                               true ->
                                   if is_palindrome(Word) ->
                                          [[Idx, EmptyIdx], [EmptyIdx, Idx] | CurrentAcc];
                                      true -> CurrentAcc
                                   end
                            end
                        end, Acc, lists:zip(Words, lists:seq(0, length(Words) - 1)));
        false -> Acc
    end.

process_word(Word, Idx, WordsMap, Acc) ->
    % Case a: w1 = reverse(w2)
    WordRev = lists:reverse(Word),
    Acc1 = case maps:is_key(WordRev, WordsMap) of
        true ->
            OtherIdx = maps:get(WordRev, WordsMap),
            if Idx == OtherIdx -> Acc;
               true -> [[Idx, OtherIdx] | Acc]
            end;
        false -> Acc
    end,

    % Case b: splits
    WordLen = length(Word),
    SplitResults = lists:foldl(fun(k, CurrentAcc) ->
                                   Prefix = lists:sublist(Word, k),
                                   Suffix = lists:nthtail(k, Word),

                                   % Case b.i: prefix is palindrome (words[j] + words[i])
                                   AccAfterPrefixCheck = if is_palindrome(Prefix) ->
                                                             TargetWord = lists:reverse(Suffix),
                                                             case maps:is_key(TargetWord, WordsMap) of
                                                                 true ->
                                                                     OtherIdx = maps:get(TargetWord, WordsMap),
                                                                     if Idx == OtherIdx -> CurrentAcc;
                                                                        true -> [[OtherIdx, Idx] | CurrentAcc]
                                                                     end;
                                                                 false -> CurrentAcc
                                                             end;
                                                         true -> CurrentAcc
                                                         end,

                                   % Case b.ii: suffix is palindrome (words[i] + words[j])
                                   AccAfterSuffixCheck = if is_palindrome(Suffix) ->
                                                             TargetWord = lists:reverse(Prefix),
                                                             case maps:is_key(TargetWord, WordsMap) of
                                                                 true ->
                                                                     OtherIdx = maps:get(TargetWord, WordsMap),
                                                                     if Idx == OtherIdx -> AccAfterPrefixCheck;
                                                                        true -> [[Idx, OtherIdx] | AccAfterPrefixCheck]
                                                                     end;
                                                                 false -> AccAfterPrefixCheck
                                                             end;
                                                         true -> AccAfterPrefixCheck
                                                         end,
                                   AccAfterSuffixCheck
                               end, Acc1, lists:seq(1, WordLen - 1)),
    SplitResults.