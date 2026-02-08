-spec unique_paths(M :: integer(), N :: integer()) -> integer().
unique_paths(M, N) ->
    DP = lists:duplicate(M, 1),
    unique_paths(2, N, DP).

unique_paths(_, 1, DP) ->
    lists:nth(1, DP);
unique_paths(Row, Col, DP) ->
    NewDP = update_dp(2, Row, DP, [1]),
    unique_paths(Row + 1, Col - 1, NewDP).

update_dp(_, 1, _, Acc) ->
    lists:reverse(Acc);
update_dp(Index, Row, DP, Acc) ->
    Value = lists:nth(Index - 1, Acc) + lists:nth(Index, DP),
    update_dp(Index + 1, Row, DP, [Value | Acc]).