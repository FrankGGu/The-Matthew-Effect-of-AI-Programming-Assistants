-module(solution).
-export([findAndReplacePattern/2]).

findAndReplacePattern(Words, Pattern) ->
    lists:filter(fun(Word) -> matches(Word, Pattern) end, Words).

matches(Word, Pattern) ->
    if
        length(Word) =:= length(Pattern) ->
            check_match(Word, Pattern, #{}, #{} );
        true ->
            false
    end.

check_match([], [], _PMap, _WMap) ->
    true;
check_match([WChar|WTail], [PChar|PTail], PMap, WMap) ->
    case maps:is_key(PChar, PMap) of
        true ->
            case maps:get(PChar, PMap) of
                WChar ->
                    check_match(WTail, PTail, PMap, WMap);
                _ ->
                    false
            end;
        false ->
            case maps:is_key(WChar, WMap) of
                true ->
                    false;
                false ->
                    NewPMap = maps:put(PChar, WChar, PMap),
                    NewWMap = maps:put(WChar, PChar, WMap),
                    check_match(WTail, PTail, NewPMap, NewWMap)
            end
    end;
check_match(_, _, _, _) ->
    false.