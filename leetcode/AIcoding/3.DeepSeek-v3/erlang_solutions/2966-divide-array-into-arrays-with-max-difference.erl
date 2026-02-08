-spec divide_array(Nums :: [integer()], K :: integer()) -> [[integer()]].
divide_array(Nums, K) ->
    Sorted = lists:sort(Nums),
    divide(Sorted, K, []).

divide([], _, Acc) ->
    lists:reverse(Acc);
divide([A, B, C | Rest], K, Acc) ->
    case C - A =< K of
        true -> divide(Rest, K, [[A, B, C] | Acc]);
        false -> []
    end;
divide(_, _, _) ->
    [].