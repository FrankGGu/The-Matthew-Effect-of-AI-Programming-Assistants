-spec remove_duplicates(Nums :: [integer()]) -> integer().
remove_duplicates(Nums) ->
    remove_duplicates(Nums, 0, -10001, 0).

remove_duplicates([], Index, _, Count) ->
    Count;
remove_duplicates([H | T], Index, Prev, Count) ->
    case H =/= Prev of
        true ->
            lists:nth(Index + 1, Nums) = H,
            remove_duplicates(T, Index + 1, H, Count + 1);
        false ->
            remove_duplicates(T, Index, Prev, Count)
    end.