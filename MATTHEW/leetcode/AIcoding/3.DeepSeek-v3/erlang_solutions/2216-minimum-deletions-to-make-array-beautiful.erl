-spec min_deletion(Nums :: [integer()]) -> integer().
min_deletion(Nums) ->
    min_deletion(Nums, 0, 0).

min_deletion([], _, Deletions) ->
    Deletions;
min_deletion([_], Index, Deletions) when Index rem 2 == 0 ->
    Deletions + 1;
min_deletion([X, Y | Rest], Index, Deletions) when Index rem 2 == 0 ->
    if
        X == Y ->
            min_deletion([X | Rest], Index, Deletions + 1);
        true ->
            min_deletion([Y | Rest], Index + 1, Deletions)
    end;
min_deletion([_ | Rest], Index, Deletions) ->
    min_deletion(Rest, Index + 1, Deletions).