-spec orderly_queue(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
orderly_queue(S, K) ->
    case K of
        1 ->
            Min = S,
            Len = byte_size(S),
            Rotated = rotate(S, Len - 1),
            find_min(Min, Rotated, Len - 1);
        _ ->
            Sorted = list_to_binary(lists:sort(binary_to_list(S))),
            Sorted
    end.

rotate(S, 0) -> [S];
rotate(S, N) -> [S | rotate(<<(binary:part(S, 1, byte_size(S) - 1))/binary, (binary:part(S, 0, 1))/binary>>, N - 1)].

find_min(Min, [], _) -> Min;
find_min(Min, [H | T], N) ->
    case H < Min of
        true -> find_min(H, T, N - 1);
        false -> find_min(Min, T, N - 1)
    end.