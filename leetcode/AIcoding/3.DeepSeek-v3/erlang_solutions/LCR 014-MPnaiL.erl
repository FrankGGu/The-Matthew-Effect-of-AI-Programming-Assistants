-spec check_inclusion(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> boolean().
check_inclusion(S1, S2) ->
    Len1 = byte_size(S1),
    Len2 = byte_size(S2),
    if
        Len1 > Len2 -> false;
        true ->
            S1Count = lists:foldl(fun(C, Acc) -> 
                maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, binary_to_list(S1)),
            WindowCount = lists:foldl(fun(C, Acc) -> 
                maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, binary_to_list(binary:part(S2, 0, Len1))),
            check(S1Count, WindowCount, S2, Len1, Len1, Len2)
    end.

check(S1Count, WindowCount, S2, Len1, Left, Len2) ->
    case maps:to_list(S1Count) == maps:to_list(WindowCount) of
        true -> true;
        false when Left >= Len2 -> false;
        false ->
            LeftChar = binary:at(S2, Left - Len1),
            RightChar = binary:at(S2, Left),
            NewWindowCount1 = maps:update_with(LeftChar, fun(V) -> V - 1 end, WindowCount),
            NewWindowCount2 = case maps:get(LeftChar, NewWindowCount1, 0) of
                0 -> maps:remove(LeftChar, NewWindowCount1);
                _ -> NewWindowCount1
            end,
            NewWindowCount3 = maps:update_with(RightChar, fun(V) -> V + 1 end, 1, NewWindowCount2),
            check(S1Count, NewWindowCount3, S2, Len1, Left + 1, Len2)
    end.