-spec distribute_elements(Nums :: [integer()]) -> [integer()].
distribute_elements(Nums) ->
    [H1, H2 | Rest] = Nums,
    {FinalArr1Rev, FinalArr2Rev} = distribute_helper(Rest, [H1], [H2]),
    lists:reverse(FinalArr1Rev) ++ lists:reverse(FinalArr2Rev).

distribute_helper([], Arr1Rev, Arr2Rev) ->
    {Arr1Rev, Arr2Rev};
distribute_helper([H | T], Arr1Rev, Arr2Rev) ->
    Last1 = hd(Arr1Rev),
    Last2 = hd(Arr2Rev),
    if
        Last1 > Last2 ->
            distribute_helper(T, [H | Arr1Rev], Arr2Rev);
        true -> %% Last1 <= Last2
            distribute_helper(T, Arr1Rev, [H | Arr2Rev])
    end.