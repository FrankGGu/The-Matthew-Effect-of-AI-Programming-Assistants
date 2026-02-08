-spec rearrange_array(Nums :: [integer()]) -> [integer()].
rearrange_array(Nums) ->
    {Positives, Negatives} = lists:partition(fun(X) -> X > 0 end, Nums),
    rearrange(Positives, Negatives, []).

rearrange([], [], Acc) ->
    lists:reverse(Acc);
rearrange([P | Positives], [N | Negatives], Acc) ->
    rearrange(Positives, Negatives, [N, P | Acc]).