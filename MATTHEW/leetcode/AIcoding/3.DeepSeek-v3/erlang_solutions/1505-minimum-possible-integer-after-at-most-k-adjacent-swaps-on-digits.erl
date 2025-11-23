-spec min_integer(Num :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
min_integer(Num, K) ->
    List = binary_to_list(Num),
    Result = minimize(List, K),
    list_to_binary(Result).

minimize(List, 0) -> List;
minimize([], _) -> [];
minimize(List, K) ->
    {MinChar, Index} = find_min(List, min(length(List) - 1, K) + 1),
    NewList = move_to_front(List, Index),
    minimize(NewList, K - Index).

find_min(List, MaxPos) ->
    find_min(List, MaxPos, 1, hd(List), 1).

find_min([], _, _, MinChar, MinIndex) -> {MinChar, MinIndex - 1};
find_min([H | T], MaxPos, Pos, MinChar, MinIndex) ->
    if
        Pos > MaxPos -> {MinChar, MinIndex - 1};
        H < MinChar -> find_min(T, MaxPos, Pos + 1, H, Pos);
        true -> find_min(T, MaxPos, Pos + 1, MinChar, MinIndex)
    end.

move_to_front(List, 1) -> List;
move_to_front([H | T], Index) ->
    {Prefix, [Char | Suffix]} = lists:split(Index - 1, [H | T]),
    [Char | Prefix ++ Suffix].