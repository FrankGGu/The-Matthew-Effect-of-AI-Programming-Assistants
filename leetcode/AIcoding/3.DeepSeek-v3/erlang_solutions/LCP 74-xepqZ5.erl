-module(solution).
-export([field_of_greatest_blessing/1]).

field_of_greatest_blessing(ForceFields) ->
    {Xs, Ys} = lists:unzip([{X - L/2, Y - L/2} || {X, Y, L} <- ForceFields] ++ [{X + L/2, Y + L/2} || {X, Y, L} <- ForceFields]),
    SortedXs = lists:sort(Xs),
    SortedYs = lists:sort(Ys),
    CandXs = lists:usort(SortedXs),
    CandYs = lists:usort(SortedYs),
    Max = 0,
    {Ans, _} = lists:foldl(fun(X, {Acc, PrevX}) ->
        lists:foldl(fun(Y, {InnerAcc, PrevY}) ->
            Count = count_rectangles(ForceFields, PrevX, PrevY, X, Y),
            {max(InnerAcc, Count), Y}
        end, {Acc, hd(CandYs)}, tl(CandYs)),
        {Acc, X}
    end, {Max, hd(CandXs)}, tl(CandXs)),
    Ans.

count_rectangles(ForceFields, X1, Y1, X2, Y2) ->
    lists:foldl(fun({X, Y, L}, Acc) ->
        case (X - L/2 =< X1) andalso (X + L/2 >= X2) andalso (Y - L/2 =< Y1) andalso (Y + L/2 >= Y2) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, ForceFields).