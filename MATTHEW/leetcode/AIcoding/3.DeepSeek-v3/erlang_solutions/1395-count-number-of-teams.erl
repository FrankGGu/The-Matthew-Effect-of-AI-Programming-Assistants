-spec num_teams(Rating :: [integer()]) -> integer().
num_teams(Rating) ->
    N = length(Rating),
    Count = 0,
    {Result, _} = lists:foldl(fun(I, {Acc, _}) ->
        {LeftLess, LeftGreater} = {0, 0},
        {RightLess, RightGreater} = {0, 0},
        {LeftLess1, LeftGreater1} = lists:foldl(fun(J, {LL, LG}) ->
            case lists:nth(J, Rating) < lists:nth(I, Rating) of
                true -> {LL + 1, LG};
                false -> {LL, LG + 1}
            end
        end, {LeftLess, LeftGreater}, lists:seq(1, I - 1)),
        {RightLess1, RightGreater1} = lists:foldl(fun(J, {RL, RG}) ->
            case lists:nth(J, Rating) > lists:nth(I, Rating) of
                true -> {RL, RG + 1};
                false -> {RL + 1, RG}
            end
        end, {RightLess, RightGreater}, lists:seq(I + 1, N)),
        {Acc + LeftLess1 * RightGreater1 + LeftGreater1 * RightLess1, 0}
    end, {Count, 0}, lists:seq(1, N)),
    Result.