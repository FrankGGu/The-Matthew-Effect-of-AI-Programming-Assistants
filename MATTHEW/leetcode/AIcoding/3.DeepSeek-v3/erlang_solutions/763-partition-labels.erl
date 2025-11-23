-spec partition_labels(S :: unicode:unicode_binary()) -> [integer()].
partition_labels(S) ->
    Last = maps:from_list([{C, I} || {I, C} <- lists:zip(lists:seq(0, byte_size(S) - 1), binary_to_list(S))]),
    partition_labels(S, 0, 0, 0, Last, []).

partition_labels(<<>>, _, _, _, _, Acc) ->
    lists:reverse(Acc);
partition_labels(<<C/utf8, Rest/binary>>, I, Start, End, Last, Acc) ->
    NewEnd = max(End, maps:get(C, Last)),
    case I of
        NewEnd ->
            partition_labels(Rest, I + 1, NewEnd + 1, NewEnd + 1, Last, [NewEnd - Start + 1 | Acc]);
        _ ->
            partition_labels(Rest, I + 1, Start, NewEnd, Last, Acc)
    end.