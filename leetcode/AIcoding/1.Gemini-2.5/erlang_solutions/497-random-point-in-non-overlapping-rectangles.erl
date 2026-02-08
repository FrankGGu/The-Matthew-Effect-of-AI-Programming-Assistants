-module(solution).
-export([init/1, pick/1]).

init(Rects) ->
    rand:seed_s(exsplus, os:timestamp()),

    {CombinedDataReversed, TotalArea} = lists:foldl(
        fun([X1, Y1, X2, Y2] = Rect, {AccCombined, AccTotalArea}) ->
            Width = X2 - X1,
            Height = Y2 - Y1,
            Area = Width * Height,
            NewTotalArea = AccTotalArea + Area,
            {[{NewTotalArea, Rect} | AccCombined], NewTotalArea}
        end,
        {[], 0},
        Rects
    ),

    CorrectOrderCombinedData = lists:reverse(CombinedDataReversed),

    {ok, {CorrectOrderCombinedData, TotalArea}}.

pick({CombinedData, TotalArea}) ->
    RandVal = rand:uniform() * TotalArea,

    [X1, Y1, X2, Y2] = find_rectangle(RandVal, CombinedData),

    RandX = X1 + rand:uniform() * (X2 - X1),
    RandY = Y1 + rand:uniform() * (Y2 - Y1),

    [RandX, RandY].

find_rectangle(RandVal, [{CumArea, Rect} | Rest]) ->
    if
        RandVal < CumArea ->
            Rect;
        true ->
            find_rectangle(RandVal, Rest)
    end.