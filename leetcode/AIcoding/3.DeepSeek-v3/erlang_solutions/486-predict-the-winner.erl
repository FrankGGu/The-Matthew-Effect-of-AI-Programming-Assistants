-spec predict_the_winner(Nums :: [integer()]) -> boolean().
predict_the_winner(Nums) ->
    N = length(Nums),
    DP = lists:duplicate(N, lists:duplicate(N, 0)),
    DP1 = init_dp(DP, Nums, 0, N - 1),
    MaxScore = get_max_score(DP1, Nums, 0, N - 1),
    Total = lists:sum(Nums),
    MaxScore >= Total - MaxScore.

init_dp(DP, Nums, I, I) ->
    Row = lists:nth(I + 1, DP),
    NewRow = setelement(I + 1, Row, lists:nth(I + 1, Nums)),
    setelement(I + 1, DP, NewRow);
init_dp(DP, _, _, _) -> DP.

get_max_score(DP, Nums, I, J) ->
    case I > J of
        true -> 0;
        false ->
            case element(J + 1, element(I + 1, DP)) of
                0 ->
                    Left = lists:nth(I + 1, Nums) + min(get_max_score(DP, Nums, I + 2, J), get_max_score(DP, Nums, I + 1, J - 1)),
                    Right = lists:nth(J + 1, Nums) + min(get_max_score(DP, Nums, I + 1, J - 1), get_max_score(DP, Nums, I, J - 2)),
                    NewDP = update_dp(DP, I, J, max(Left, Right)),
                    max(Left, Right);
                Cached -> Cached
            end
    end.

update_dp(DP, I, J, Value) ->
    Row = element(I + 1, DP),
    NewRow = setelement(J + 1, Row, Value),
    setelement(I + 1, DP, NewRow).