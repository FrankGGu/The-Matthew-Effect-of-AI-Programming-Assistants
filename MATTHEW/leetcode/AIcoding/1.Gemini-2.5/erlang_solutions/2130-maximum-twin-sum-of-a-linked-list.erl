-spec max_twin_sum(Head :: [integer()]) -> integer().
max_twin_sum(Head) ->
    N = length(Head),
    RevHead = lists:reverse(Head),

    AllSums = lists:zipwith(fun(X, Y) -> X + Y end, Head, RevHead),

    HalfN = N div 2,

    TwinSums = lists:sublist(AllSums, 1, HalfN),

    lists:max(TwinSums).