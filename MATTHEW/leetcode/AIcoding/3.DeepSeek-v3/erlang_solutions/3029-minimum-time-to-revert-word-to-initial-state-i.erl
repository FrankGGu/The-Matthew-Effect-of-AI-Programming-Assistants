-spec minimum_time_to_initial_state(Word :: unicode:unicode_binary(), K :: integer()) -> integer().
minimum_time_to_initial_state(Word, K) ->
    N = byte_size(Word),
    minimum_time_to_initial_state(Word, K, N, 1).

minimum_time_to_initial_state(Word, K, N, Time) ->
    PrefixLength = Time * K,
    if
        PrefixLength >= N -> Time;
        true ->
            case binary:part(Word, 0, N - PrefixLength) =:= binary:part(Word, PrefixLength, N - PrefixLength) of
                true -> Time;
                false -> minimum_time_to_initial_state(Word, K, N, Time + 1)
            end
    end.