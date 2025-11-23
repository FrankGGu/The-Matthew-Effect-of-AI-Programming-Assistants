-spec max_sum(nums :: [integer()]) -> integer().
max_sum(Nums) ->
    MaxDigits = lists:foldl(fun(N, Acc) ->
        Digits = [D - $0 || D <- integer_to_list(N)],
        MaxD = lists:max(Digits),
        maps:update_with(MaxD, fun(Old) -> lists:sort([N | Old]) end, [N], Acc)
    end, maps:new(), Nums),
    Pairs = maps:fold(fun(_, List, Acc) ->
        case lists:reverse(lists:sort(List)) of
            [A, B | _] -> [A + B | Acc];
            _ -> Acc
        end
    end, [], MaxDigits),
    case Pairs of
        [] -> -1;
        _ -> lists:max(Pairs)
    end.