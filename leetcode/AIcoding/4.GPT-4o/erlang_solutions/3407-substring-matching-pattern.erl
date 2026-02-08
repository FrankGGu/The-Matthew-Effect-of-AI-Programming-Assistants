-module(solution).
-export([find_and_replace_pattern/2]).

find_and_replace_pattern(Words, Pattern) ->
    lists:filter(fun(Word) -> match_pattern(Word, Pattern) end, Words).

match_pattern(Word, Pattern) ->
    match(Word, Pattern, maps:new(), maps:new()).

match(Word, Pattern, WordMap, PatternMap) ->
    case {lists:reverse(Word), lists:reverse(Pattern)} of
        {[], []} -> true;
        {WordH, PatternH} ->
            case {maps:get(WordH, WordMap, undefined), maps:get(PatternH, PatternMap, undefined)} of
                {undefined, undefined} ->
                    match(tl(WordH), tl(PatternH), maps:put(WordH, PatternH, WordMap), maps:put(PatternH, WordH, PatternMap));
                {W, P} when W =:= PatternH -> match(tl(WordH), tl(PatternH), WordMap, PatternMap);
                _ -> false
            end
    end.