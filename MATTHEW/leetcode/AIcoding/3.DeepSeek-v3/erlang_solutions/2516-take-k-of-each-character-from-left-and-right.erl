-spec take_characters(S :: unicode:unicode_binary(), K :: integer()) -> integer().
take_characters(S, K) ->
    case K =:= 0 of
        true -> 0;
        false ->
            Counts = #{<<"a">> => 0, <<"b">> => 0, <<"c">> => 0},
            Total = count_chars(S, Counts),
            case maps:fold(fun(_, V, Acc) -> Acc andalso (V >= K) end, true, Total) of
                false -> -1;
                true ->
                    Len = byte_size(S),
                    MinLen = find_min_len(S, K, Total, Len),
                    MinLen
            end
    end.

count_chars(S, Counts) ->
    count_chars(S, 0, byte_size(S), Counts).

count_chars(S, Index, Len, Counts) when Index < Len ->
    Char = binary:part(S, Index, 1),
    NewCounts = maps:update_with(Char, fun(V) -> V + 1 end, Counts),
    count_chars(S, Index + 1, Len, NewCounts);
count_chars(_, _, _, Counts) ->
    Counts.

find_min_len(S, K, Total, Len) ->
    Left = 0,
    Right = Len,
    find_min_len(S, K, Total, Len, Left, Right, Len).

find_min_len(S, K, Total, Len, Left, Right, MinLen) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    case is_possible(S, K, Total, Len, Mid) of
        true ->
            NewMinLen = min(Mid, MinLen),
            find_min_len(S, K, Total, Len, Left, Mid - 1, NewMinLen);
        false ->
            find_min_len(S, K, Total, Len, Mid + 1, Right, MinLen)
    end;
find_min_len(_, _, _, _, _, _, MinLen) ->
    MinLen.

is_possible(S, K, Total, Len, Window) ->
    Counts = #{<<"a">> => 0, <<"b">> => 0, <<"c">> => 0},
    {LeftCounts, RightCounts} = count_window(S, Len, Window, Counts, Counts),
    maps:fold(fun(Key, V, Acc) ->
        Acc andalso (maps:get(Key, Total) - maps:get(Key, LeftCounts) - maps:get(Key, RightCounts) >= K
    end, true, Total).

count_window(S, Len, Window, LeftCounts, RightCounts) ->
    count_window(S, Len, Window, 0, Len - 1, LeftCounts, RightCounts).

count_window(S, Len, Window, Left, Right, LeftCounts, RightCounts) when Window > 0, Left =< Right ->
    case Window > 0 of
        true ->
            LeftChar = binary:part(S, Left, 1),
            NewLeftCounts = maps:update_with(LeftChar, fun(V) -> V + 1 end, LeftCounts),
            count_window(S, Len, Window - 1, Left + 1, Right, NewLeftCounts, RightCounts);
        false ->
            {LeftCounts, RightCounts}
    end;
count_window(S, Len, Window, Left, Right, LeftCounts, RightCounts) when Window > 0, Left =< Right ->
    RightChar = binary:part(S, Right, 1),
    NewRightCounts = maps:update_with(RightChar, fun(V) -> V + 1 end, RightCounts),
    count_window(S, Len, Window - 1, Left, Right - 1, LeftCounts, NewRightCounts);
count_window(_, _, _, _, _, LeftCounts, RightCounts) ->
    {LeftCounts, RightCounts}.