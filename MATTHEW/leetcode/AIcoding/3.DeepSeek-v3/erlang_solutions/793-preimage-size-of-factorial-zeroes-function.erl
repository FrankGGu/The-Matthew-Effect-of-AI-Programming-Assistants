-spec preimage_size_fzf(K :: integer()) -> integer().
preimage_size_fzf(K) ->
    Left = 0,
    Right = 5 * (K + 1),
    case binary_search(Left, Right, K) of
        not_found -> 0;
        _ -> 5
    end.

binary_search(Left, Right, K) ->
    if
        Left > Right -> not_found;
        true ->
            Mid = Left + (Right - Left) div 2,
            Zeros = trailing_zeros(Mid),
            if
                Zeros == K -> Mid;
                Zeros < K -> binary_search(Mid + 1, Right, K);
                true -> binary_search(Left, Mid - 1, K)
            end
    end.

trailing_zeros(N) ->
    trailing_zeros(N, 0).

trailing_zeros(0, Acc) -> Acc;
trailing_zeros(N, Acc) ->
    trailing_zeros(N div 5, Acc + N div 5).