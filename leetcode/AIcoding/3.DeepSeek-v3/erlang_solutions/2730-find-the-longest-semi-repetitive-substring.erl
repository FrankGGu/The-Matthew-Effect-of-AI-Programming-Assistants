-spec longest_semi_repetitive_substring(S :: unicode:unicode_binary()) -> integer().
longest_semi_repetitive_substring(S) ->
    Bin = unicode:characters_to_binary(S),
    Size = byte_size(Bin),
    case Size of
        0 -> 0;
        1 -> 1;
        _ ->
            MaxLen = 1,
            Left = 0,
            Count = 0,
            do_loop(Bin, 1, Left, Count, MaxLen, Size)
    end.

do_loop(Bin, Right, Left, Count, MaxLen, Size) when Right < Size ->
    Current = binary:at(Bin, Right),
    Prev = binary:at(Bin, Right - 1),
    NewCount = if
        Current == Prev -> Count + 1;
        true -> Count
    end,
    if
        NewCount =< 1 ->
            NewMaxLen = max(MaxLen, Right - Left + 1),
            do_loop(Bin, Right + 1, Left, NewCount, NewMaxLen, Size);
        true ->
            NewLeft = find_new_left(Bin, Left, Right),
            do_loop(Bin, Right + 1, NewLeft, NewCount - 1, MaxLen, Size)
    end;
do_loop(_Bin, _Right, _Left, _Count, MaxLen, _Size) ->
    MaxLen.

find_new_left(Bin, Left, Right) ->
    find_new_left(Bin, Left, Right, Right - 1).

find_new_left(Bin, Left, Right, Pos) when Pos >= Left ->
    case binary:at(Bin, Pos) == binary:at(Bin, Pos + 1) of
        true -> Pos + 1;
        false -> find_new_left(Bin, Left, Right, Pos - 1)
    end;
find_new_left(_Bin, Left, _Right, _Pos) ->
    Left.