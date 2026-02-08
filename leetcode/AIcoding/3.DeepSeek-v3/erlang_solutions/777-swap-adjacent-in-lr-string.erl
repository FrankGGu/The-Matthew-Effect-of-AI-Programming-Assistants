-spec can_transform(Start :: unicode:unicode_binary(), End :: unicode:unicode_binary()) -> boolean().
can_transform(Start, End) ->
    case byte_size(Start) =:= byte_size(End) of
        false -> false;
        true ->
            StartBin = binary_to_list(Start),
            EndBin = binary_to_list(End),
            can_transform(StartBin, EndBin, 0, 0)
    end.

can_transform([], [], _, _) -> true;
can_transform([$X | StartT], [$X | EndT], I, J) ->
    can_transform(StartT, EndT, I + 1, J + 1);
can_transform([$X | StartT], End, I, J) ->
    can_transform(StartT, End, I + 1, J);
can_transform(Start, [$X | EndT], I, J) ->
    can_transform(Start, EndT, I, J + 1);
can_transform([$L | _], [$R | _], _, _) -> false;
can_transform([$R | _], [$L | _], _, _) -> false;
can_transform([$L | StartT], [$L | EndT], I, J) when I >= J ->
    can_transform(StartT, EndT, I + 1, J + 1);
can_transform([$R | StartT], [$R | EndT], I, J) when I =< J ->
    can_transform(StartT, EndT, I + 1, J + 1);
can_transform(_, _, _, _) -> false.