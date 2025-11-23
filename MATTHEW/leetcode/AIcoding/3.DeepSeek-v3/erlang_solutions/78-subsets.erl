-spec subsets(Nums :: [integer()]) -> [[integer()]].
subsets(Nums) ->
    subsets(Nums, [], [[]]).

subsets([], _Current, Acc) ->
    Acc;
subsets([H | T], Current, Acc) ->
    NewAcc = [Current ++ [H] | Acc],
    subsets(T, Current ++ [H], subsets(T, Current, NewAcc)).