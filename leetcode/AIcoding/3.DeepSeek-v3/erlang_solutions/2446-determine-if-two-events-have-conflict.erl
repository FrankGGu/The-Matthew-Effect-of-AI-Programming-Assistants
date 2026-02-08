-spec have_conflict(Event1 :: [unicode:unicode_binary()], Event2 :: [unicode:unicode_binary()]) -> boolean().
have_conflict(Event1, Event2) ->
    [Start1, End1] = Event1,
    [Start2, End2] = Event2,
    StartTime1 = binary_to_integer(binary:replace(Start1, <<":">>, <<>>)),
    EndTime1 = binary_to_integer(binary:replace(End1, <<":">>, <<>>)),
    StartTime2 = binary_to_integer(binary:replace(Start2, <<":">>, <<>>)),
    EndTime2 = binary_to_integer(binary:replace(End2, <<":">>, <<>>)),
    not (EndTime1 < StartTime2 orelse EndTime2 < StartTime1).