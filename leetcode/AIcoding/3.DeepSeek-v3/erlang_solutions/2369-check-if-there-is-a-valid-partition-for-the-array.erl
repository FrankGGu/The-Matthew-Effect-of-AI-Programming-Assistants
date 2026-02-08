-spec valid_partition(Nums :: [integer()]) -> boolean().
valid_partition(Nums) ->
    N = length(Nums),
    DP = array:new([{size, N + 1}, {default, false}]),
    DP1 = array:set(0, true, DP),
    DP2 = case N >= 2 of
        true ->
            case lists:nth(1, Nums) =:= lists:nth(2, Nums) of
                true -> array:set(2, true, DP1);
                false -> DP1
            end;
        false -> DP1
    end,
    DP3 = case N >= 3 of
        true ->
            Cond1 = lists:nth(1, Nums) =:= lists:nth(2, Nums) andalso lists:nth(2, Nums) =:= lists:nth(3, Nums),
            Cond2 = lists:nth(1, Nums) + 1 =:= lists:nth(2, Nums) andalso lists:nth(2, Nums) + 1 =:= lists:nth(3, Nums),
            case Cond1 orelse Cond2 of
                true -> array:set(3, true, DP2);
                false -> DP2
            end;
        false -> DP2
    end,
    DP4 = lists:foldl(fun(I, Acc) ->
        case I >= 4 of
            true ->
                Cond1 = array:get(I - 2, Acc) andalso (lists:nth(I - 1, Nums) =:= lists:nth(I, Nums)),
                Cond2 = array:get(I - 3, Acc) andalso (lists:nth(I - 2, Nums) =:= lists:nth(I - 1, Nums) andalso lists:nth(I - 1, Nums) =:= lists:nth(I, Nums)),
                Cond3 = array:get(I - 3, Acc) andalso (lists:nth(I - 2, Nums) + 1 =:= lists:nth(I - 1, Nums) andalso lists:nth(I - 1, Nums) + 1 =:= lists:nth(I, Nums)),
                case Cond1 orelse Cond2 orelse Cond3 of
                    true -> array:set(I, true, Acc);
                    false -> Acc
                end;
            false -> Acc
        end
    end, DP3, lists:seq(4, N)),
    array:get(N, DP4).