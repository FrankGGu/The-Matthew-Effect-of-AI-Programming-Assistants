-module(solution).
-export([find_and_replace_pattern/2]).

find_and_replace_pattern(Words, Pattern) ->
    lists:filter(fun(Word) -> match_pattern(Word, Pattern) end, Words).

match_pattern(Word, Pattern) ->
    match(Word, Pattern, dict:new(), dict:new()).

match(Word, Pattern, WMap, PMap) ->
    case {dict:find(Word, WMap), dict:find(Pattern, PMap)} of
        {ok, WVal} -> 
            WVal == dict:find(Pattern, PMap);
        {error, _} -> 
            case dict:find(Pattern, PMap) of
                {ok, PVal} -> 
                    PVal == dict:find(Word, WMap);
                error -> 
                    WMap1 = dict:store(Word, Pattern, WMap),
                    PMap1 = dict:store(Pattern, Word, PMap),
                    match(lists:tl(Word), lists:tl(Pattern), WMap1, PMap1)
            end
    end.

match([], []) -> true;
match(_, []) -> false;
match([], _) -> false.