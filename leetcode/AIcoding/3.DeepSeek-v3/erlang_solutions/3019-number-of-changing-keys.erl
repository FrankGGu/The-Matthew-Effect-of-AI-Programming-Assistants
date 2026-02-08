-spec count_key_changes(S :: unicode:unicode_binary()) -> integer().
count_key_changes(S) ->
    count_key_changes(S, 0, undefined).

count_key_changes(<<>>, Count, _Prev) ->
    Count;
count_key_changes(<<Char:8, Rest/binary>>, Count, Prev) ->
    LowerChar = to_lower(Char),
    if
        Prev =:= undefined ->
            count_key_changes(Rest, Count, LowerChar);
        LowerChar =/= Prev ->
            count_key_changes(Rest, Count + 1, LowerChar);
        true ->
            count_key_changes(Rest, Count, LowerChar)
    end.

to_lower(Char) when Char >= $A, Char =< $Z ->
    Char + 32;
to_lower(Char) ->
    Char.