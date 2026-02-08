-spec permute_unique(Nums :: [integer()]) -> [[integer()]].
permute_unique(Nums) ->
    permute_unique(Nums, []).

permute_unique([], Acc) -> [Acc];
permute_unique([H|T], Acc) ->
    lists:flatten([permute_unique(T, [H|Acc]) || _ <- lists:seq(1, length(T))]).
