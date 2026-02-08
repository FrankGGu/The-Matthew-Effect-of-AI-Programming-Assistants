-spec min_operations(Nums :: [integer()], K :: integer()) -> integer().
min_operations(Nums, K) ->
    N = length(Nums),
    case N rem K of
        0 -> 
            Groups = lists:foldl(fun(I, Acc) ->
                Group = lists:map(fun(J) -> lists:nth(((I - 1) * K + J) rem N + 1, Nums) end, lists:seq(1, K)),
                [Group | Acc]
            end, [], lists:seq(1, N div K)),
            lists:sum(lists:map(fun(Group) ->
                Sorted = lists:sort(Group),
                Median = lists:nth((K + 1) div 2, Sorted),
                lists:sum(lists:map(fun(X) -> abs(X - Median) end, Group))
            end, Groups));
        _ -> -1
    end.