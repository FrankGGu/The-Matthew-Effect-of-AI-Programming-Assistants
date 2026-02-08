-spec reverse_only_letters(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_only_letters(S) ->
    List = unicode:characters_to_list(S),
    Letters = lists:filter(fun(C) -> (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z) end, List),
    ReversedLetters = lists:reverse(Letters),
    {Result, _} = lists:foldl(fun(C, {Acc, Rev}) ->
        case (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z) of
            true -> {[hd(Rev) | Acc], tl(Rev)};
            false -> {[C | Acc], Rev}
        end
    end, {[], ReversedLetters}, List),
    unicode:characters_to_binary(lists:reverse(Result)).