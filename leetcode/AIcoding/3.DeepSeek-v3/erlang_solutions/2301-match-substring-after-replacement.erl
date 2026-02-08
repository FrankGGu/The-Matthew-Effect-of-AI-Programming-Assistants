-spec match_substring_after_replacement(S :: unicode:unicode_binary(), Sub :: unicode:unicode_binary(), M :: [[char()]]) -> boolean().
match_substring_after_replacement(S, Sub, M) ->
    SList = unicode:characters_to_list(S),
    SubList = unicode:characters_to_list(Sub),
    MMap = lists:foldl(fun([U, V], Acc) ->
                           maps:put(U, maps:get(U, Acc, sets:new()) union sets:from_list([V]), Acc)
                       end, #{}, M),
    LenS = length(SList),
    LenSub = length(SubList),
    if
        LenSub > LenS -> false;
        true ->
            check_substrings(SList, SubList, MMap, 0, LenS - LenSub)
    end.

check_substrings(_, _, _, Start, End) when Start > End -> false;
check_substrings(S, Sub, MMap, Start, End) ->
    case check_substring(S, Sub, MMap, Start, 0) of
        true -> true;
        false -> check_substrings(S, Sub, MMap, Start + 1, End)
    end.

check_substring(S, Sub, MMap, SIndex, SubIndex) when SubIndex =:= length(Sub) -> true;
check_substring(S, Sub, MMap, SIndex, SubIndex) ->
    SChar = lists:nth(SIndex + 1, S),
    SubChar = lists:nth(SubIndex + 1, Sub),
    if
        SChar =:= SubChar -> check_substring(S, Sub, MMap, SIndex + 1, SubIndex + 1);
        true ->
            case maps:find(SubChar, MMap) of
                {ok, Allowed} ->
                    case sets:is_element(SChar, Allowed) of
                        true -> check_substring(S, Sub, MMap, SIndex + 1, SubIndex + 1);
                        false -> false
                    end;
                error -> false
            end
    end.