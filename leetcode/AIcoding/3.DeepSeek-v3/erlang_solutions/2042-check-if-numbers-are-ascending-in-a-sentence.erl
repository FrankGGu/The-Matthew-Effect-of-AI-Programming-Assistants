-spec are_numbers_ascending(S :: unicode:unicode_binary()) -> boolean().
are_numbers_ascending(S) ->
    Words = string:lexemes(S, " "),
    Numbers = lists:filtermap(fun(Word) ->
        case string:to_integer(Word) of
            {Num, []} -> {true, Num};
            _ -> false
        end
    end, Words),
    is_ascending(Numbers).

is_ascending([]) -> true;
is_ascending([_]) -> true;
is_ascending([A, B | Rest]) when A < B -> is_ascending([B | Rest]);
is_ascending(_) -> false.