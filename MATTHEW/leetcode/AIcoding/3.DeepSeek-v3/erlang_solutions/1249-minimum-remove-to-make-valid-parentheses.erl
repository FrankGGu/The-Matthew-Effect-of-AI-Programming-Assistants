-spec min_remove_to_make_valid(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
min_remove_to_make_valid(S) ->
    {S1, Open} = process(S, 0, []),
    {S2, _} = lists:foldl(fun(Char, {Acc, OpenCount}) ->
        case Char of
            $( when OpenCount > 0 ->
                {[Char | Acc], OpenCount - 1};
            $( ->
                {Acc, OpenCount};
            _ ->
                {[Char | Acc], OpenCount}
        end
    end, {[], Open}, S1),
    unicode:characters_to_binary(lists:reverse(S2)).

process(<<>>, Open, Acc) ->
    {lists:reverse(Acc), Open};
process(<<$(, Rest/binary>>, Open, Acc) ->
    process(Rest, Open + 1, [$( | Acc]);
process(<<$), Rest/binary>>, Open, Acc) when Open > 0 ->
    process(Rest, Open - 1, [$) | Acc]);
process(<<$), Rest/binary>>, Open, Acc) ->
    process(Rest, Open, Acc);
process(<<Char, Rest/binary>>, Open, Acc) ->
    process(Rest, Open, [Char | Acc]).