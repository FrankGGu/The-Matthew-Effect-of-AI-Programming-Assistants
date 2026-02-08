-spec max_score(CardPoints :: [integer()], K :: integer()) -> integer().
max_score(CardPoints, K) ->
    N = length(CardPoints),
    Total = lists:sum(CardPoints),
    WindowSize = N - K,
    case WindowSize of
        0 -> Total;
        _ ->
            WindowSum = lists:sum(lists:sublist(CardPoints, 1, WindowSize)),
            MinSum = WindowSum,
            {MinSum, _} = lists:foldl(fun(I, {CurrentMin, CurrentSum}) ->
                NewSum = CurrentSum - lists:nth(I, CardPoints) + lists:nth(I + WindowSize, CardPoints),
                {min(CurrentMin, NewSum), NewSum}
            end, {WindowSum, WindowSum}, lists:seq(1, K)),
            Total - MinSum
    end.