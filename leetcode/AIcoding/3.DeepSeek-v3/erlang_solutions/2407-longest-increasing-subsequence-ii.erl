-spec length_of_lis(Nums :: [integer()], K :: integer()) -> integer().
length_of_lis(Nums, K) ->
    T = gb_trees:empty(),
    lists:foldl(fun(Num, Tree) ->
        case gb_trees:lookup(Num, Tree) of
            {value, Val} ->
                gb_trees:enter(Num, Val, Tree);
            none ->
                case gb_trees:is_empty(gb_trees:iterator_from(Num - K, Tree)) of
                    true ->
                        MaxPrev = 0;
                    false ->
                        {_, MaxPrev, _} = gb_trees:largest(gb_trees:iterator_from(Num - K, Tree))
                end,
                NewVal = MaxPrev + 1,
                gb_trees:enter(Num, NewVal, Tree)
        end
    end, T, Nums),
    case gb_trees:is_empty(T) of
        true -> 0;
        false -> {_, Max, _} = gb_trees:largest(T), Max
    end.