-spec knight_probability(N :: integer(), K :: integer(), Row :: integer(), Column :: integer()) -> float().
knight_probability(N, K, Row, Column) ->
    DP = maps:new(),
    {Result, _} = dp(N, K, Row, Column, DP),
    Result.

dp(_, 0, Row, Column, DP) ->
    case is_inside(Row, Column, N) of
        true -> {1.0, DP};
        false -> {0.0, DP}
    end;
dp(N, K, Row, Column, DP) ->
    case maps:get({Row, Column, K}, DP, undefined) of
        undefined ->
            Directions = [{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 1}],
            {Sum, NewDP} = lists:foldl(
                fun({Dr, Dc}, {Acc, AccDP}) ->
                    NewRow = Row + Dr,
                    NewCol = Column + Dc,
                    case is_inside(NewRow, NewCol, N) of
                        true ->
                            {Prob, UpdatedDP} = dp(N, K - 1, NewRow, NewCol, AccDP),
                            {Acc + Prob / 8, UpdatedDP};
                        false ->
                            {Acc, AccDP}
                    end
                end,
                {0.0, DP},
                Directions
            ),
            {Sum, maps:put({Row, Column, K}, Sum, NewDP)};
        Cached ->
            {Cached, DP}
    end.

is_inside(Row, Col, N) ->
    Row >= 0 andalso Row < N andalso Col >= 0 andalso Col < N.