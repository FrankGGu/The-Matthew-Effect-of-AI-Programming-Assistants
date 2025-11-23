-spec beautiful_indices(S :: unicode:unicode_binary(), A :: unicode:unicode_binary(), B :: unicode:unicode_binary(), K :: integer()) -> [integer()].
beautiful_indices(S, A, B, K) ->
    N = byte_size(S),
    M1 = byte_size(A),
    M2 = byte_size(B),
    IndicesA = find_indices(S, A, N, M1),
    IndicesB = find_indices(S, B, N, M2),
    lists:sort(lists:filter(fun(I) -> is_beautiful(I, IndicesB, K) end, IndicesA)).

find_indices(S, Pattern, N, M) ->
    lists:reverse(find_indices(S, Pattern, N, M, 0, [])).

find_indices(S, Pattern, N, M, I, Acc) when I + M =< N ->
    case binary:match(binary:part(S, I, M), Pattern) of
        {0, _} -> find_indices(S, Pattern, N, M, I + 1, [I | Acc]);
        _ -> find_indices(S, Pattern, N, M, I + 1, Acc)
    end;
find_indices(_, _, _, _, _, Acc) -> Acc.

is_beautiful(I, IndicesB, K) ->
    lists:any(fun(J) -> abs(I - J) =< K end, IndicesB).