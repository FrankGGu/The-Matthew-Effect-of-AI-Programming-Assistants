-module(solution).
-export([spellchecker/2]).

mask_vowels(S) ->
    lists:map(fun(C) ->
                  case C of
                      $a -> $*;
                      $e -> $*;
                      $i -> $*;
                      $o -> $*;
                      $u -> $*;
                      _ -> C
                  end
              end, S).

spellchecker(Wordlist, Queries) ->
    %% 1. Build ExactWords set for Rule 1 (case-sensitive exact match)
    ExactWords = sets:from_list(Wordlist),

    %% 2. Build LowerCaseMap for Rule 2 (case-insensitive exact match)
    %%    Key: lowercase version of word
    %%    Value: original-cased word (first encountered)
    LowerCaseMap = lists:foldl(fun(Word, Acc) ->
                                   LowerWord = string:to_lower(Word),
                                   case maps:is_key(LowerWord, Acc) of
                                       true -> Acc;
                                       false -> maps:put(LowerWord, Word, Acc)
                                   end
                               end, maps:new(), Wordlist),

    %% 3. Build VowelMaskMap for Rule 3 (vowel-error match)
    %%    Key: lowercase word with vowels replaced by '*'
    %%    Value: original-cased word (first encountered)
    VowelMaskMap = lists:foldl(fun(Word, Acc) ->
                                   LowerWord = string:to_lower(Word),
                                   VowelMaskedWord = mask_vowels(LowerWord),
                                   case maps:is_key(VowelMaskedWord, Acc) of
                                       true -> Acc;
                                       false -> maps:put(VowelMaskedWord, Word, Acc)
                                   end
                               end, maps:new(), Wordlist),

    %% Process each query
    lists:map(fun(Query) ->
                  case sets:is_element(Query, ExactWords) of
                      true ->
                          Query; %% Rule 1: Case-sensitive exact match
                      false ->
                          LowerQuery = string:to_lower(Query),
                          case maps:get(LowerQuery, LowerCaseMap, undefined) of
                              undefined ->
                                  VowelMaskedQuery = mask_vowels(LowerQuery),
                                  case maps:get(VowelMaskedQuery, VowelMaskMap, undefined) of
                                      undefined ->
                                          ""; %% Rule 4: No match found
                                      Match ->
                                          Match %% Rule 3: Vowel-error match
                                  end;
                              Match ->
                                  Match %% Rule 2: Case-insensitive exact match
                          end
                  end
              end, Queries).