-spec max_non_overlapping(Nums :: [integer()], Target :: integer()) -> integer().
max_non_overlapping(Nums, Target) ->
    PrefixSum = 0,
    SumSet = sets:new(),
    sets:add_element(PrefixSum, SumSet),
    Count = 0,
    {_, Res} = lists:foldl(fun(Num, {Sum, Cnt}) ->
        NewSum = Sum + Num,
        case sets:is_element(NewSum - Target, SumSet) of
            true ->
                NewSet = sets:new(),
                sets:add_element(NewSum, NewSet),
                {NewSum, Cnt + 1};
            false ->
                NewSet = sets:add_element(NewSum, SumSet),
                {NewSum, Cnt}
        end
    end, {PrefixSum, Count}, Nums),
    Res.