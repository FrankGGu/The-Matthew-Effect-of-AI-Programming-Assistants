-spec partition_string(S :: unicode:unicode_binary()) -> integer().
partition_string(S) ->
    partition_string(S, sets:new(), 1).

partition_string(<<>>, _Set, Count) ->
    Count;
partition_string(<<Char/utf8, Rest/binary>>, Set, Count) ->
    case sets:is_element(Char, Set) of
        true ->
            partition_string(Rest, sets:from_list([Char]), Count + 1);
        false ->
            partition_string(Rest, sets:add_element(Char, Set), Count)
    end.