-spec subsets(Nums :: [integer()]) -> [[integer()]].
subsets(Nums) -> subsets(Nums, []).

subsets([], Acc) -> [Acc];
subsets([H|T], Acc) -> 
    [Acc] ++ subsets(T, Acc) ++ subsets(T, [H|Acc]).
