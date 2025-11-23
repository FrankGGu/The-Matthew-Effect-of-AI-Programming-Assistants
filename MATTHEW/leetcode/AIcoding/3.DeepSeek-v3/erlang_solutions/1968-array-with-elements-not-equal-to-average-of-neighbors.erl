-spec rearrange_array(Nums :: [integer()]) -> [integer()].
rearrange_array(Nums) ->
    Sorted = lists:sort(Nums),
    rearrange(Sorted, []).

rearrange([], Acc) -> Acc;
rearrange([X], Acc) -> [X | Acc];
rearrange([X, Y | Rest], Acc) ->
    rearrange(Rest, [Y, X | Acc]).