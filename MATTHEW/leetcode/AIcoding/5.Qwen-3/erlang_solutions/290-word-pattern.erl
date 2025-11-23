-module(word_pattern).
-export([contains_pattern/2]).

contains_pattern(Pattern, S) ->
    Words = string:split(S, " "),
    if
        length(Pattern) /= length(Words) -> false;
        true -> match_pattern(Pattern, Words, #{} , #{})
    end.

match_pattern([], [], _PMap, _WMap) -> true;
match_pattern([P|Pt], [W|Wt], PMap, WMap) ->
    case maps:find(P, PMap) of
        {ok, W} -> match_pattern(Pt, Wt, PMap, WMap);
        error ->
            case maps:find(W, WMap) of
                {ok, P} -> match_pattern(Pt, Wt, PMap, WMap);
                error -> match_pattern(Pt, Wt, maps:put(P, W, PMap), maps:put(W, P, WMap))
            end
    end.