-spec partition_array(Nums :: [integer()], K :: integer()) -> integer().
partition_array(Nums, K) ->
    Sorted = lists:sort(Nums),
    partition(Sorted, K, 1, 0).

partition([], _, Count, _) -> Count;
partition([H | T], K, Count, Start) ->
    case lists:splitwith(fun(X) -> X =< H + K end, T) of
        {[], _} -> partition([], K, Count + 1, Start);
        {Group, Rest} -> partition(Rest, K, Count + 1, Start + length(Group) + 1
    end.