-spec shift_grid(Grid :: [[integer()]], K :: integer()) -> [[integer()]].
shift_grid(Grid, K) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Total = M * N,
    K1 = K rem Total,
    Flat = lists:flatten(Grid),
    Shifted = shift_list(Flat, K1),
    reshape(Shifted, M, N).

shift_list(List, K) ->
    Len = length(List),
    case K of
        0 -> List;
        _ ->
            {Left, Right} = lists:split(Len - K, List),
            Right ++ Left
    end.

reshape(List, M, N) ->
    reshape(List, M, N, []).

reshape(_, 0, _, Acc) ->
    lists:reverse(Acc);
reshape(List, M, N, Acc) ->
    {Row, Rest} = lists:split(N, List),
    reshape(Rest, M - 1, N, [Row | Acc]).