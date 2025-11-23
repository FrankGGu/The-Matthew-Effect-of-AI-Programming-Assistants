-spec subarray_bitwise_ors(Arr :: [integer()]) -> integer().
subarray_bitwise_ors(Arr) ->
    Res = sets:new(),
    Prev = sets:new(),
    lists:foldl(fun(X, _) ->
        Curr = sets:new(),
        sets:add_element(X, Curr),
        sets:fold(fun(Y, Acc) ->
            sets:add_element(Y bor X, Curr),
            Acc
        end, ok, Prev),
        sets:fold(fun(Y, Acc) ->
            sets:add_element(Y, Res),
            Acc
        end, ok, Curr),
        Curr
    end, ok, Arr),
    sets:size(Res).