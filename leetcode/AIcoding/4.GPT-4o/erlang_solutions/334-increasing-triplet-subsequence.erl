-spec increasing_triplet(Nums :: [integer()]) -> boolean().
increasing_triplet(Nums) ->
    increasing_triplet(Nums, infinity, infinity).

increasing_triplet([], _, _) -> false;
increasing_triplet([Head | Tail], Min1, Min2) when Head <= Min1 ->
    increasing_triplet(Tail, Head, Min2);
increasing_triplet([Head | Tail], Min1, Min2) when Head <= Min2 ->
    increasing_triplet(Tail, Min1, Head);
increasing_triplet([Head | _], Min1, Min2) when Head > Min2 -> true.
