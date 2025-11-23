-spec sort_people(Names :: [unicode:unicode_binary()], Heights :: [integer()]) -> [unicode:unicode_binary()].
sort_people(Names, Heights) ->
    Combined = lists:zip(Heights, Names),
    Sorted = lists:reverse(lists:sort(Combined)),
    [Name || {_Height, Name} <- Sorted].