-module(sum_game).
-export([sumGame/1]).

sumGame(Num) ->
    {LeftSum, LeftQ, RightSum, RightQ} = parse(Num),
    TotalSum = LeftSum - RightSum,
    TotalQ = LeftQ - RightQ,
    case TotalQ of
        0 -> TotalSum /= 0;
        _ -> (TotalQ rem 2 == 0) andalso (TotalSum + (TotalQ div 2) * 9 /= 0)
    end.

parse(Num) ->
    {Left, Right} = lists:split(length(Num) div 2, Num),
    {SumLeft, QLeft} = calculate(Left),
    {SumRight, QRight} = calculate(Right),
    {SumLeft, QLeft, SumRight, QRight}.

calculate(Str) ->
    lists:foldl(fun
        ($?, {Sum, Q}) -> {Sum, Q + 1};
        (C, {Sum, Q}) -> {Sum + (C - $0), Q}
    end, {0, 0}, Str).