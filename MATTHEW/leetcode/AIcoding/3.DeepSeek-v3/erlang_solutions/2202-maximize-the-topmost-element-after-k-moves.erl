-spec maximum_top(Nums :: [integer()], K :: integer()) -> integer().
maximum_top(Nums, K) ->
    case Nums of
        [] -> -1;
        [X] when K rem 2 =:= 1 -> -1;
        [X] -> X;
        _ ->
            case K of
                0 -> hd(Nums);
                _ ->
                    Max = lists:max(Nums),
                    if
                        K > length(Nums) -> Max;
                        K =:= length(Nums) -> lists:max(lists:sublist(Nums, K - 1));
                        true -> lists:max([hd(lists:sublist(Nums, K - 1)), Max])
                    end
            end
    end.

hd([H|_]) -> H.