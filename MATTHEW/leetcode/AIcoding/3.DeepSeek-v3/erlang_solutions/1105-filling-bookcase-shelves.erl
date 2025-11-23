-spec min_height_shelves(Books :: [[integer()]], ShelfWidth :: integer()) -> integer().
min_height_shelves(Books, ShelfWidth) ->
    N = length(Books),
    Dp = array:new([{size, N + 1}, {default, 0}]),
    {_, Result} = lists:foldl(
        fun(I, {DpAcc, _}) ->
            {CurrentWidth, CurrentHeight} = lists:nth(I, Books),
            Dp1 = array:set(I, array:get(I - 1, DpAcc) + CurrentHeight, DpAcc),
            {Dp2, _} = lists:foldl(
                fun(J, {DpInner, {W, H}}) ->
                    {Wj, Hj} = lists:nth(J, Books),
                    NewW = W + Wj,
                    NewH = max(H, Hj),
                    if
                        NewW =< ShelfWidth ->
                            MinHeight = min(array:get(I, DpInner), array:get(J - 1, DpInner) + NewH),
                            {array:set(I, MinHeight, DpInner), {NewW, NewH}};
                        true ->
                            {DpInner, {W, H}}
                    end
                end,
                {Dp1, {CurrentWidth, CurrentHeight}},
                lists:seq(I - 1, 1, -1)
            ),
            {Dp2, array:get(I, Dp2)}
        end,
        {Dp, 0},
        lists:seq(1, N)
    ),
    Result.