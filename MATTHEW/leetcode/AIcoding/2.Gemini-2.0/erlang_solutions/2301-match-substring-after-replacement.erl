-module(match_replacement).
-export([match_replacement/3]).

match_replacement(S, Sub, Mappings) ->
    SLen = length(S),
    SubLen = length(Sub),
    case SLen < SubLen of
        true ->
            false;
        false ->
            match_replacement(S, Sub, Mappings, 0, SLen, SubLen)
    end.

match_replacement(S, Sub, Mappings, Start, SLen, SubLen) ->
    case Start + SubLen > SLen of
        true ->
            false;
        false ->
            case is_match(S, Sub, Mappings, Start) of
                true ->
                    true;
                false ->
                    match_replacement(S, Sub, Mappings, Start + 1, SLen, SubLen)
            end
    end.

is_match(S, Sub, Mappings, Start) ->
    is_match(S, Sub, Mappings, Start, 1).

is_match(S, Sub, Mappings, Start, SubIndex) ->
    case SubIndex > length(Sub) of
        true ->
            true;
        false ->
            SChar = lists:nth(Start + SubIndex - 1, S),
            SubChar = lists:nth(SubIndex, Sub),
            case (SChar == SubChar) orelse is_replacement(SubChar, SChar, Mappings) of
                true ->
                    is_match(S, Sub, Mappings, Start, SubIndex + 1);
                false ->
                    false
            end
    end.

is_replacement(SubChar, SChar, Mappings) ->
    lists:member({SubChar, SChar}, Mappings).