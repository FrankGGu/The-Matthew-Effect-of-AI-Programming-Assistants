-spec thousand_separator(N :: integer()) -> unicode:unicode_binary().
thousand_separator(N) ->
    Str = integer_to_list(N),
    Len = length(Str),
    thousand_separator(Str, Len, [], 0).

thousand_separator([], _, Acc, _) ->
    list_to_binary(lists:reverse(Acc));
thousand_separator([H | T], Len, Acc, Count) when Count > 0, Count rem 3 =:= 0 ->
    thousand_separator([H | T], Len, [$. | Acc], Count);
thousand_separator([H | T], Len, Acc, Count) ->
    thousand_separator(T, Len, [H | Acc], Count + 1).