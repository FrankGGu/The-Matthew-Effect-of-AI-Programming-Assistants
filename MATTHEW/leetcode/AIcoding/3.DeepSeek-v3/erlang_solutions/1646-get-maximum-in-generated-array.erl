-spec get_maximum_generated(N :: integer()) -> integer().
get_maximum_generated(N) ->
    case N of
        0 -> 0;
        1 -> 1;
        _ ->
            Arr = array:new(N + 1, {default, 0}),
            Arr1 = array:set(0, 0, Arr),
            Arr2 = array:set(1, 1, Arr1),
            Max = lists:foldl(fun(I, Acc) ->
                case I rem 2 of
                    0 ->
                        Val = array:get(I div 2, Arr2),
                        NewArr = array:set(I, Val, Arr2),
                        {NewArr, max(Acc, Val)};
                    1 ->
                        Half = I div 2,
                        Val = array:get(Half, Arr2) + array:get(Half + 1, Arr2),
                        NewArr = array:set(I, Val, Arr2),
                        {NewArr, max(Acc, Val)}
                end
            end, 1, lists:seq(2, N)),
            element(2, Max)
    end.