-spec min_moves(Nums :: [integer()], Limit :: integer()) -> integer().
min_moves(Nums, Limit) ->
    N = length(Nums),
    Pairs = lists:zip(lists:sublist(Nums, 1, N div 2), lists:reverse(Nums)),
    Diff = array:new([{size, 2 * Limit + 2}, {default, 0}]),
    {Diff1, _} = lists:foldl(fun({A, B}, {D, _}) ->
        Min = min(A, B),
        Max = max(A, B),
        D1 = array:set(2, array:get(2, D) + 1, D),
        D2 = array:set(Min + 1, array:get(Min + 1, D1) - 1, D1),
        D3 = array:set(Min + Max, array:get(Min + Max, D2) - 1, D2),
        D4 = array:set(Min + Max + 1, array:get(Min + Max + 1, D3) + 1, D3),
        D5 = array:set(Max + Limit + 1, array:get(Max + Limit + 1, D4) + 1, D4),
        {D5, 0}
    end, {Diff, 0}, Pairs),
    {Res, _} = lists:foldl(fun(I, {MinMoves, Current}) ->
        Current1 = Current + array:get(I, Diff1),
        if Current1 < MinMoves -> {Current1, Current1};
           true -> {MinMoves, Current1}
        end
    end, {N, 0}, lists:seq(2, 2 * Limit)),
    Res.