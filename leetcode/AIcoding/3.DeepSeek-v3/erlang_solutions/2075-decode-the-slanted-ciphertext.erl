-spec decode_ciphertext(EncodedText :: unicode:unicode_binary(), Rows :: integer()) -> unicode:unicode_binary().
decode_ciphertext(EncodedText, Rows) ->
    case EncodedText of
        <<>> -> <<>>;
        _ ->
            Len = byte_size(EncodedText),
            Cols = Len div Rows,
            decode(EncodedText, Rows, Cols, 0, 0, <<>>)
    end.

decode(EncodedText, Rows, Cols, Row, Col, Acc) when Row < Rows, Col < Cols ->
    Index = Row * Cols + Col,
    Char = binary:at(EncodedText, Index),
    decode(EncodedText, Rows, Cols, Row + 1, Col + 1, <<Acc/binary, Char>>);
decode(EncodedText, Rows, Cols, _, Col, Acc) when Col < Cols ->
    decode(EncodedText, Rows, Cols, 0, Col, Acc);
decode(_, _, _, _, _, Acc) ->
    trim_trailing_spaces(Acc).

trim_trailing_spaces(Bin) ->
    case binary:matches(Bin, <<" ">>) of
        [] -> Bin;
        Matches ->
            {Pos, _} = lists:last(Matches),
            case Pos + 1 =:= byte_size(Bin) of
                true -> trim_trailing_spaces(binary:part(Bin, 0, Pos));
                false -> Bin
            end
    end.