-spec shortest_completing_word(LicensePlate :: unicode:unicode_binary(), Words :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
shortest_completing_word(LicensePlate, Words) ->
    Target = to_lowercase_count(LicensePlate),
    Filtered = lists:filter(fun(Word) -> can_complete(Target, to_lowercase_count(Word)) end, Words),
    {MinLength, _} = lists:foldl(fun(Word, {Min, Acc}) ->
        Length = byte_size(Word),
        if
            Length < Min -> {Length, Word};
            true -> {Min, Acc}
        end
    end, {999999, <<>>}, Filtered),
    lists:foldl(fun(Word, Acc) ->
        Length = byte_size(Word),
        if
            Length =:= MinLength -> Word;
            true -> Acc
        end
    end, <<>>, Filtered).

to_lowercase_count(Str) ->
    lists:foldl(fun(Char, Acc) ->
        if
            Char >= $A, Char =< $Z -> 
                Lower = Char + 32,
                maps:update_with(Lower, fun(V) -> V + 1 end, 1, Acc);
            Char >= $a, Char =< $z -> 
                maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc);
            true -> Acc
        end
    end, #{}, binary_to_list(Str)).

can_complete(Target, WordCount) ->
    maps:fold(fun(Char, Count, Acc) ->
        case maps:get(Char, WordCount, 0) of
            WordCount when WordCount >= Count -> Acc;
            _ -> false
        end
    end, true, Target).