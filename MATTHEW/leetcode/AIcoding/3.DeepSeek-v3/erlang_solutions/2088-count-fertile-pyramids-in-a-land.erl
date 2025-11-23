-spec count_pyramids(Grid :: [[integer()]]) -> integer().
count_pyramids(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    Pyramids = 0,
    {DP1, Pyramids1} = count_pyramids(Grid, M, N, DP, Pyramids),
    InvertedGrid = lists:reverse(Grid),
    {_DP2, Pyramids2} = count_pyramids(InvertedGrid, M, N, DP, Pyramids1),
    Pyramids2.

count_pyramids(Grid, M, N, DP, Pyramids) ->
    lists:foldl(fun(I, {DPAcc, PyramidsAcc}) ->
        lists:foldl(fun(J, {DPRow, PyramidsRow}) ->
            case I == 0 orelse J == 0 orelse J == N - 1 of
                true ->
                    Val = lists:nth(J + 1, lists:nth(I + 1, Grid)),
                    NewDPRow = setelement(J + 1, DPRow, Val),
                    {NewDPRow, PyramidsRow};
                false ->
                    Curr = lists:nth(J + 1, lists:nth(I + 1, Grid)),
                    if
                        Curr == 0 ->
                            NewDPRow = setelement(J + 1, DPRow, 0),
                            {NewDPRow, PyramidsRow};
                        true ->
                            Left = element(J, lists:nth(I, DPAcc)),
                            Up = element(J + 1, lists:nth(I, DPAcc)),
                            Right = element(J + 2, lists:nth(I, DPAcc)),
                            Min = min(min(Left, Up), Right),
                            NewVal = Min + 1,
                            NewDPRow = setelement(J + 1, DPRow, NewVal),
                            {NewDPRow, PyramidsRow + NewVal}
                    end
            end
        end, {lists:nth(I + 1, DPAcc), PyramidsAcc}, lists:seq(0, N - 1))
    end, {DP, Pyramids}, lists:seq(0, M - 1)).