-spec subsets_with_dup(Nums :: [integer()]) -> [[integer()]].
subsets_with_dup(Nums) ->
    Sorted = lists:sort(Nums),
    subsets(Sorted, [], []).

subsets([], Current, Acc) ->
    [Current | Acc];
subsets([H | T], Current, Acc) ->
    NewAcc = subsets(T, [H | Current], Acc),
    case T =/= [] andalso hd(T) =:= H of
        true ->
            subsets(tl(T), Current, NewAcc);
        false ->
            subsets(T, Current, NewAcc)
    end.