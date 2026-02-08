-spec num_different_integers(Word :: unicode:unicode_binary()) -> integer().
num_different_integers(Word) ->
    {ok, RE} = re:compile("\\d+", [unicode]),
    case re:run(Word, RE, [global, {capture, all, binary}]) of
        {match, Matches} ->
            Stripped = lists:map(fun([Match]) -> 
                binary_to_integer(remove_leading_zeros(Match)) 
            end, Matches),
            length(sets:to_list(sets:from_list(Stripped)));
        nomatch ->
            0
    end.

remove_leading_zeros(Bin) ->
    case binary:match(Bin, <<"0">>) of
        {0, _} ->
            case binary:match(Bin, <<"[1-9]">>) of
                nomatch -> <<"0">>;
                {Pos, _} -> binary:part(Bin, Pos, byte_size(Bin) - Pos)
            end;
        _ ->
            Bin
    end.