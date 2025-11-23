-module(find_and_replace_pattern).
-export([find_and_replace_pattern/2]).

find_and_replace_pattern(Words, Pattern) ->
    lists:filter(fun(Word) ->
        match_pattern(Word, Pattern)
    end, Words).

match_pattern(Word, Pattern) ->
    Len = length(Word),
    if Len /= length(Pattern) ->
        false
    else
        match_pattern_helper(Word, Pattern, [], [])
    end.

match_pattern_helper([], [], _, _) ->
    true;
match_pattern_helper([W | RestW], [P | RestP], WMap, PMap) ->
    case (lists:keyfind(W, 1, WMap), lists:keyfind(P, 1, PMap)) of
        {W, ExistingP}, {P, ExistingW} ->
            if ExistingP == P andalso ExistingW == W then
                match_pattern_helper(RestW, RestP, WMap, PMap)
            else
                false
            end;
        {W, _}, _ ->
            false;
        _, {P, _} ->
            false;
        _ ->
            match_pattern_helper(RestW, RestP, [{W, P} | WMap], [{P, W} | PMap])
    end.