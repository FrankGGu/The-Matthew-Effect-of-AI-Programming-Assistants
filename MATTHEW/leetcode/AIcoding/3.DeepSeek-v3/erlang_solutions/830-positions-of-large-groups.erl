-spec large_group_positions(S :: unicode:unicode_binary()) -> [[integer()]].
large_group_positions(S) ->
    large_group_positions(S, 0, 1, []).

large_group_positions(<<>>, _Start, _Len, Acc) ->
    lists:reverse(Acc);
large_group_positions(<<C, Rest/binary>>, Start, Len, Acc) ->
    case Rest of
        <<C, NextRest/binary>> ->
            large_group_positions(Rest, Start, Len + 1, Acc);
        _ ->
            if
                Len >= 3 ->
                    NewAcc = [[Start, Start + Len - 1] | Acc],
                    large_group_positions(Rest, Start + Len, 1, NewAcc);
                true ->
                    large_group_positions(Rest, Start + Len, 1, Acc)
            end
    end.