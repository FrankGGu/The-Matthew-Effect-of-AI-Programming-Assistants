-module(word_filter).
-export([new/1, f/3]).

-record(state, {map :: map()}).

new(Words) ->
    Map = maps:new(),
    IndexedWords = lists:zip(Words, lists:seq(0, length(Words) - 1)),
    FinalMap = lists:foldl(fun({Word, Index}, AccMap) ->
        WordLen = length(Word),
        % Generate all possible prefixes, including the empty string
        Prefixes = [string:substr(Word, 1, PIdx) || PIdx <- lists:seq(0, WordLen)],
        % Generate all possible suffixes, including the empty string
        Suffixes = [string:substr(Word, WordLen - SufLen + 1, SufLen) || SufLen <- lists:seq(0, WordLen)],

        lists:foldl(fun(Prefix, CurrentMap) ->
            lists:foldl(fun(Suffix, InnerMap) ->
                maps:put({Prefix, Suffix}, Index, InnerMap)
            end, CurrentMap, Suffixes)
        end, AccMap, Prefixes)
    end, Map, IndexedWords),
    #state{map = FinalMap}.

f(#state{map = Map}, Prefix, Suffix) ->
    maps:get({Prefix, Suffix}, Map, -1).