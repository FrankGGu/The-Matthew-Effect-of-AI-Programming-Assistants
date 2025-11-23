-spec difference_of_sum(Nums :: [integer()]) -> integer().
difference_of_sum(Nums) ->
    ElementSum = lists:sum(Nums),
    DigitSum = lists:sum([lists:sum([Digit - $0 || Digit <- integer_to_list(Num)]) || Num <- Nums]),
    abs(ElementSum - DigitSum).