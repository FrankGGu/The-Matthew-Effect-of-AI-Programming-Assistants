-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) -> 
    max_product(Nums, 0, 0, 0).

max_product([], Max, _, _) -> Max;
max_product([Head | Tail], Max, Min, Prev) ->
    CurrMax = max(Head, max(Prev * Head, Prev * Head)),
    CurrMin = min(Head, min(Prev * Head, Prev * Head)),
    max_product(Tail, max(Max, CurrMax), CurrMin, CurrMax).
