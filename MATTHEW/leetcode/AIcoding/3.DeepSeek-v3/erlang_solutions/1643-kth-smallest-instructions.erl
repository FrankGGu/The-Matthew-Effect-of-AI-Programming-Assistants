-spec kth_smallest_path(Destination :: [integer()], K :: integer()) -> [integer()].
kth_smallest_path(Destination, K) ->
    [V, H] = Destination,
    Total = V + H,
    Path = lists:duplicate(Total, 0),
    build_path(V, H, K, Path, 1).

build_path(0, 0, _, Path, _) -> Path;
build_path(V, H, K, Path, Pos) ->
    if
        V == 0 ->
            lists:sublist(Path, Pos - 1) ++ lists:duplicate(H, 1);
        H == 0 ->
            lists:sublist(Path, Pos - 1) ++ lists:duplicate(V, 0);
        true ->
            C = comb(V + H - 1, V),
            if
                K =< C ->
                    build_path(V - 1, H, K, Path, Pos + 1);
                true ->
                    NewPath = lists:sublist(Path, Pos - 1) ++ [1] ++ lists:nthtail(Pos, Path),
                    build_path(V, H - 1, K - C, NewPath, Pos + 1)
            end
    end.

comb(N, K) ->
    if
        K > N -> 0;
        K == 0 -> 1;
        K > N - K -> comb(N, N - K);
        true ->
            Res = 1,
            comb(N, K, Res, 1)
    end.

comb(N, K, Res, I) ->
    if
        I > K -> Res;
        true ->
            NewRes = Res * (N - K + I) div I,
            comb(N, K, NewRes, I + 1)
    end.