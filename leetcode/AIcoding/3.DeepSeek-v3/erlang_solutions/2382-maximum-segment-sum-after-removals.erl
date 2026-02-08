-spec maximum_segment_sum(Nums :: [integer()], RemoveQueries :: [integer()]) -> [integer()].
maximum_segment_sum(Nums, RemoveQueries) ->
    N = length(Nums),
    Parent = array:new([{size, N}, {default, -1}]),
    Sum = array:new([{size, N}, {default, 0}]),
    {Result, _, _} = lists:foldr(fun(Query, {Res, P, S}) ->
        Pos = Query + 1,
        NewP = array:set(Pos, Pos, P),
        NewS = array:set(Pos, lists:nth(Query + 1, Nums), S),
        Left = if Pos > 1 -> find(Pos - 1, NewP); true -> -1 end,
        Right = if Pos < N -> find(Pos + 1, NewP); true -> -1 end,
        {MergedP, MergedS, CurrentSum} = merge(Left, Pos, Right, NewP, NewS),
        NewRes = [CurrentSum | Res],
        {NewRes, MergedP, MergedS}
    end, {[], Parent, Sum}, RemoveQueries),
    lists:reverse(Result).

find(Pos, Parent) ->
    case array:get(Pos, Parent) of
        -1 -> -1;
        P when P == Pos -> Pos;
        P ->
            Root = find(P, Parent),
            array:set(Pos, Root, Parent),
            Root
    end.

merge(Left, Pos, Right, Parent, Sum) ->
    CurrentSum = array:get(Pos, Sum),
    {NewParent1, NewSum1, Sum1} = case Left of
        -1 -> {Parent, Sum, 0};
        L ->
            LSum = array:get(L, Sum),
            {array:set(L, Pos, Parent), array:set(L, 0, Sum), LSum}
    end,
    {NewParent2, NewSum2, Sum2} = case Right of
        -1 -> {NewParent1, NewSum1, 0};
        R ->
            RSum = array:get(R, Sum),
            {array:set(R, Pos, NewParent1), array:set(R, 0, NewSum1), RSum}
    end,
    TotalSum = CurrentSum + Sum1 + Sum2,
    FinalParent = array:set(Pos, Pos, NewParent2),
    FinalSum = array:set(Pos, TotalSum, NewSum2),
    {FinalParent, FinalSum, TotalSum}.