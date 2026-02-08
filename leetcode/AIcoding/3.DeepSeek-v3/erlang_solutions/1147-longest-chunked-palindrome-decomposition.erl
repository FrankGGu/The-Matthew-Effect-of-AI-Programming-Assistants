-spec longest_decomposition(Text :: unicode:unicode_binary()) -> integer().
longest_decomposition(Text) ->
    longest_decomposition(Text, 0).

longest_decomposition(<<>>, Count) ->
    Count;
longest_decomposition(Text, Count) ->
    N = byte_size(Text),
    case find_match(Text, N) of
        {ok, K} ->
            Prefix = binary:part(Text, 0, K),
            Suffix = binary:part(Text, N - K, K),
            if
                Prefix =:= Suffix ->
                    Remaining = binary:part(Text, K, N - 2 * K),
                    longest_decomposition(Remaining, Count + 2);
                true ->
                    Count + 1
            end;
        error ->
            Count + 1
    end.

find_match(Text, N) ->
    find_match(Text, N, 1).

find_match(_, N, K) when K > N div 2 ->
    error;
find_match(Text, N, K) ->
    Prefix = binary:part(Text, 0, K),
    Suffix = binary:part(Text, N - K, K),
    if
        Prefix =:= Suffix -> {ok, K};
        true -> find_match(Text, N, K + 1)
    end.