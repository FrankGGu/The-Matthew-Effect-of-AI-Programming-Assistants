-spec get_last_moment(N :: integer(), Left :: [integer()], Right :: [integer()]) -> integer().
get_last_moment(N, Left, Right) ->
    MaxLeft = case Left of
        [] -> 0;
        _ -> lists:max(Left)
    end,
    MinRight = case Right of
        [] -> N;
        _ -> lists:min(Right)
    end,
    MaxRight = case Right of
        [] -> 0;
        _ -> N - MinRight
    end,
    max(MaxLeft, MaxRight).