-module(solution).
-export([vowelSpellchecker/2]).

vowelSpellchecker(Words, Queries) ->
    Vowels = [$a, $e, $i, $o, $u],
    VowelSubstitutions = fun(Word) ->
        lists:foldl(fun(C, Acc) -> 
            case lists:member(C, Vowels) of 
                true -> Acc ++ [$*]; 
                false -> Acc ++ [C] 
            end 
        end, [], Word)
    end,
    UniqueWords = maps:from_list(lists:map(fun(Word) -> {Word, true} end, Words)),
    VowelMap = lists:map(fun(Word) -> {VowelSubstitutions(Word), Word} end, Words),
    VowelMapUnique = maps:from_list(VowelMap),
    lists:map(fun(Query) ->
        case maps:is_key(Query, UniqueWords) of
            true -> Query;
            false ->
                VowelKey = VowelSubstitutions(Query),
                case maps:is_key(VowelKey, VowelMapUnique) of
                    true -> maps:get(VowelKey, VowelMapUnique);
                    false -> ""
                end
        end
    end, Queries).