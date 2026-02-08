-spec subsets(Nums :: [integer()]) -> [[integer()]].
subsets(Nums) ->
    subsets(Nums, [], [[]]).

subsets([], _, Acc) ->
    Acc;
subsets([H | T], Prefix, Acc) ->
    NewAcc = [Prefix ++ [H] | Acc],
    subsets(T, Prefix ++ [H], subsets(T, Prefix, NewAcc)).