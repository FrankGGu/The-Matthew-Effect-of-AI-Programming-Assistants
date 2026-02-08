-spec dest_city(Paths :: [[unicode:unicode_binary()]]) -> unicode:unicode_binary().
dest_city(Paths) ->
    From = sets:from_list([FromCity || [FromCity, _ToCity] <- Paths]),
    To = sets:from_list([ToCity || [_FromCity, ToCity] <- Paths]),
    [Destination] = sets:to_list(sets:subtract(To, From)),
    Destination.