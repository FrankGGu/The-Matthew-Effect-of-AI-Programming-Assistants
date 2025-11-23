-module(solution).
-export([minimumSum/1]).

minimumSum(Nums) ->
    N = length(Nums),
    {Min, _} = lists:foldl(fun(I, {Acc, MinIndex}) ->
        case I of
            Val when Val < Acc ->
                {Val, I};
            _ ->
                {Acc, MinIndex}
        end
    end, {lists:nth(1, Nums), 0}, lists:seq(1, N)),
    {Max, _} = lists:foldl(fun(I, {Acc, MaxIndex}) ->
        case I of
            Val when Val > Acc ->
                {Val, I};
            _ ->
                {Acc, MaxIndex}
        end
    end, {lists:nth(1, Nums), 0}, lists:seq(1, N)),
    if
        Min == Max ->
            -1;
        true ->
            Min + Max
    end.