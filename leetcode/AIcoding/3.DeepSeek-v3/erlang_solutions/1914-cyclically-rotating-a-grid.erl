-spec rotate_grid(Grid :: [[integer()]], K :: integer()) -> [[integer()]].
rotate_grid(Grid, K) ->
    case Grid of
        [] -> [];
        _ ->
            M = length(Grid),
            N = length(hd(Grid)),
            Layers = min(M, N) div 2,
            rotate_layers(Grid, M, N, Layers, K)
    end.

rotate_layers(Grid, M, N, Layers, K) ->
    lists:map(fun(Layer) ->
        Elements = extract_layer(Grid, M, N, Layer),
        Rotated = rotate_elements(Elements, K),
        place_layer(Grid, M, N, Layer, Rotated)
    end, lists:seq(0, Layers - 1)).

extract_layer(Grid, M, N, Layer) ->
    Top = lists:seq(Layer, N - Layer - 1),
    Right = lists:seq(Layer + 1, M - Layer - 1),
    Bottom = lists:seq(N - Layer - 2, Layer, -1),
    Left = lists:seq(M - Layer - 2, Layer + 1, -1),
    TopElements = [lists:nth(Col + 1, lists:nth(Row + 1, Grid)) || Row <- [Layer], Col <- Top],
    RightElements = [lists:nth(N - Layer, lists:nth(Row + 1, Grid)) || Row <- Right],
    BottomElements = [lists:nth(Col + 1, lists:nth(M - Layer, Grid)) || Col <- Bottom],
    LeftElements = [lists:nth(Layer + 1, lists:nth(Row + 1, Grid)) || Row <- Left],
    TopElements ++ RightElements ++ BottomElements ++ LeftElements.

rotate_elements(Elements, K) ->
    Len = length(Elements),
    case Len of
        0 -> Elements;
        _ ->
            Rot = K rem Len,
            {Left, Right} = lists:split(Len - Rot, Elements),
            Right ++ Left
    end.

place_layer(Grid, M, N, Layer, Elements) ->
    {NewGrid, _} = lists:foldl(fun(Row, {Acc, Index}) ->
        {lists:foldl(fun(Col, RowAcc) ->
            case is_layer_edge(Row, Col, M, N, Layer) of
                true ->
                    Elem = lists:nth(Index + 1, Elements),
                    lists:sublist(RowAcc, Col) ++ [Elem] ++ lists:nthtail(Col + 1, RowAcc);
                false ->
                    RowAcc
            end
        end, lists:nth(Row + 1, Acc), lists:seq(0, N - 1)), {Acc, Index + 1}
    end, {Grid, 0}, lists:seq(Layer, M - Layer - 1)),
    NewGrid.

is_layer_edge(Row, Col, M, N, Layer) ->
    (Row =:= Layer andalso Col >= Layer andalso Col < N - Layer) orelse
    (Col =:= N - Layer - 1 andalso Row >= Layer andalso Row < M - Layer) orelse
    (Row =:= M - Layer - 1 andalso Col >= Layer andalso Col < N - Layer) orelse
    (Col =:= Layer andalso Row >= Layer andalso Row < M - Layer).