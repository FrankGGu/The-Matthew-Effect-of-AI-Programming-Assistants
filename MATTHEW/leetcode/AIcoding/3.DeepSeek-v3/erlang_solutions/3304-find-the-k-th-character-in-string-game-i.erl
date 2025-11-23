-spec kth_character(S :: unicode:unicode_binary(), K :: integer()) -> char().
kth_character(S, K) ->
    kth_character(S, K, 0).

kth_character(S, K, Offset) ->
    case S of
        <<>> -> 0;
        <<C, Rest/binary>> when C >= $a, C =< $z ->
            Len = 1 + (C - $a),
            TotalLen = Len + Offset,
            if
                K =< TotalLen ->
                    if
                        K > Offset -> $a + (K - Offset - 1);
                        true -> kth_character(Rest, K, Offset)
                    end;
                true ->
                    kth_character(Rest, K, TotalLen)
            end;
        <<C, Rest/binary>> when C >= $A, C =< $Z ->
            Len = 1 + (C - $A),
            TotalLen = Len + Offset,
            if
                K =< TotalLen ->
                    if
                        K > Offset -> $A + (K - Offset - 1);
                        true -> kth_character(Rest, K, Offset)
                    end;
                true ->
                    kth_character(Rest, K, TotalLen)
            end;
        <<C, Rest/binary>> ->
            TotalLen = 1 + Offset,
            if
                K =< TotalLen ->
                    if
                        K > Offset -> C;
                        true -> kth_character(Rest, K, Offset)
                    end;
                true ->
                    kth_character(Rest, K, TotalLen)
            end
    end.