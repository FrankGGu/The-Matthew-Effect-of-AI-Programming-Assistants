-module(spellchecker).
-export([spellchecker/2]).

spellchecker(WordList, Queries) ->
    Exact = sets:from_list(WordList),
    LowerMap = create_lower_map(WordList),
    VowelMap = create_vowel_map(WordList),
    lists:map(fun(Query) -> check_query(Query, Exact, LowerMap, VowelMap) end, Queries).

create_lower_map(WordList) ->
    lists:foldl(fun(Word, Acc) ->
        Lower = string:to_lower(Word),
        case maps:is_key(Lower, Acc) of
            true -> Acc;
            false -> maps:put(Lower, Word, Acc)
        end
    end, maps:new(), WordList).

create_vowel_map(WordList) ->
    lists:foldl(fun(Word, Acc) ->
        Lower = string:to_lower(Word),
        VowelKey = replace_vowels(Lower),
        case maps:is_key(VowelKey, Acc) of
            true -> Acc;
            false -> maps:put(VowelKey, Word, Acc)
        end
    end, maps:new(), WordList).

replace_vowels(Word) ->
    lists:map(fun(Char) ->
        case lists:member(Char, "aeiou") of
            true -> $*;
            false -> Char
        end
    end, Word).

check_query(Query, Exact, LowerMap, VowelMap) ->
    case sets:is_element(Query, Exact) of
        true -> Query;
        false ->
            LowerQuery = string:to_lower(Query),
            case maps:find(LowerQuery, LowerMap) of
                {ok, Word} -> Word;
                error ->
                    VowelKey = replace_vowels(LowerQuery),
                    case maps:find(VowelKey, VowelMap) of
                        {ok, Word} -> Word;
                        error -> ""
                    end
            end
    end.