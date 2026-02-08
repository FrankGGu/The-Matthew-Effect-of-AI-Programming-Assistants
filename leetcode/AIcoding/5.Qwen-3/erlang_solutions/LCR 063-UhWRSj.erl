-module(replace_words).
-export([replaceWords/1]).

replaceWords(Words) ->
    WordsList = string:tokens(Words, " "),
    PrefixMap = buildPrefixMap(WordsList),
    lists:map(fun(Word) -> replaceWord(Word, PrefixMap) end, WordsList).

buildPrefixMap(Words) ->
    buildPrefixMap(Words, #{}).

buildPrefixMap([], Map) ->
    Map;
buildPrefixMap([Word | Rest], Map) ->
    Prefixes = getPrefixes(Word),
    UpdatedMap = lists:foldl(fun(Prefix, Acc) -> 
        case maps:is_key(Prefix, Acc) of
            true -> Acc;
            false -> maps:put(Prefix, Word, Acc)
        end
    end, Map, Prefixes),
    buildPrefixMap(Rest, UpdatedMap).

getPrefixes(Word) ->
    getPrefixes(Word, 1, length(Word), []).

getPrefixes(_, Start, End, Acc) when Start > End ->
    Acc;
getPrefixes(Word, Start, End, Acc) ->
    Prefix = string:substr(Word, 1, Start),
    getPrefixes(Word, Start + 1, End, [Prefix | Acc]).

replaceWord(Word, Map) ->
    replaceWord(Word, Map, 1, length(Word)).

replaceWord(_, _, Start, End) when Start > End ->
    Word;
replaceWord(Word, Map, Start, End) ->
    Prefix = string:substr(Word, 1, Start),
    case maps:is_key(Prefix, Map) of
        true -> maps:get(Prefix, Map);
        false -> replaceWord(Word, Map, Start + 1, End)
    end.