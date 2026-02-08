-spec alphabet_board_path(Target :: unicode:unicode_binary()) -> unicode:unicode_binary().
alphabet_board_path(Target) ->
    Board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"],
    PosMap = lists:foldl(fun(Row, Acc) ->
        {RowIdx, RowStr} = Row,
        lists:foldl(fun(Col, {ColIdx, Map}) ->
            Char = string:sub_string(RowStr, ColIdx, ColIdx),
            {ColIdx + 1, maps:put(Char, {RowIdx, ColIdx - 1}, Map)}
        end, {1, Acc}, lists:seq(1, length(RowStr)))
    end, #{}, lists:zip(lists:seq(0, 5), Board)),
    {Path, _} = lists:foldl(fun(Char, {Acc, {X, Y}}) ->
        {NX, NY} = maps:get([Char], PosMap),
        DX = NX - X,
        DY = NY - Y,
        Moves = 
            if 
                Char == $z ->
                    vertical_moves(DX) ++ horizontal_moves(DY);
                true ->
                    horizontal_moves(DY) ++ vertical_moves(DX)
            end,
        {Acc ++ Moves ++ "!", {NX, NY}}
    end, {"", {0, 0}}, unicode:characters_to_list(Target)),
    unicode:characters_to_binary(Path).

horizontal_moves(DY) when DY > 0 -> lists:duplicate(DY, $R);
horizontal_moves(DY) when DY < 0 -> lists:duplicate(-DY, $L);
horizontal_moves(_) -> "".

vertical_moves(DX) when DX > 0 -> lists:duplicate(DX, $D);
vertical_moves(DX) when DX < 0 -> lists:duplicate(-DX, $U);
vertical_moves(_) -> "".