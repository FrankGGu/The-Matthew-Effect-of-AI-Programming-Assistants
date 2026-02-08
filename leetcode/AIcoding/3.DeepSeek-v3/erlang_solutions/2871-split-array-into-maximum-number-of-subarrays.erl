-spec max_subarrays(Nums :: [integer()]) -> integer().
max_subarrays(Nums) ->
    {_, And} = lists:foldl(fun(N, {Res, Acc}) ->
        NewAcc = Acc band N,
        case NewAcc of
            0 -> {Res + 1, 0};
            _ -> {Res, NewAcc}
        end
    end, {0, 0}, Nums),
    case And of
        0 -> 1;
        _ -> 1
    end.