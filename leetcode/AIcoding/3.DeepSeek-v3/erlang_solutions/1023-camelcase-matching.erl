-spec camel_match(Queries :: [unicode:unicode_binary()], Pattern :: unicode:unicode_binary()) -> [boolean()].
camel_match(Queries, Pattern) ->
    lists:map(fun(Query) -> is_match(Query, Pattern) end, Queries).

is_match(Query, Pattern) ->
    QLen = byte_size(Query),
    PLen = byte_size(Pattern),
    is_match(Query, QLen, 0, Pattern, PLen, 0).

is_match(Query, QLen, QPos, Pattern, PLen, PPos) when QPos < QLen, PPos < PLen ->
    QChar = binary:at(Query, QPos),
    PChar = binary:at(Pattern, PPos),
    if
        QChar =:= PChar ->
            is_match(Query, QLen, QPos + 1, Pattern, PLen, PPos + 1);
        QChar >= $A, QChar =< $Z ->
            false;
        true ->
            is_match(Query, QLen, QPos + 1, Pattern, PLen, PPos)
    end;
is_match(Query, QLen, QPos, _Pattern, _PLen, PPos) when PPos =:= PLen ->
    check_remaining(Query, QLen, QPos);
is_match(_Query, _QLen, _QPos, _Pattern, _PLen, _PPos) ->
    false.

check_remaining(Query, QLen, QPos) when QPos < QLen ->
    QChar = binary:at(Query, QPos),
    if
        QChar >= $A, QChar =< $Z -> false;
        true -> check_remaining(Query, QLen, QPos + 1)
    end;
check_remaining(_Query, _QLen, _QPos) ->
    true.