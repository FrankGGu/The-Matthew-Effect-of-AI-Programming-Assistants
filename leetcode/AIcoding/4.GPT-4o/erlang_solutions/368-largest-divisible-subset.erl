-spec largest_divisible_subset(Nums :: [integer()]) -> [integer()].
largest_divisible_subset(Nums) ->
    NumsSorted = lists:sort(Nums),
    largest_divisible_subset(NumsSorted, []).

largest_divisible_subset([], Acc) -> lists:reverse(Acc);
largest_divisible_subset([Head | Tail], Acc) ->
    largest_divisible_subset(Tail, [Head | Acc]).
