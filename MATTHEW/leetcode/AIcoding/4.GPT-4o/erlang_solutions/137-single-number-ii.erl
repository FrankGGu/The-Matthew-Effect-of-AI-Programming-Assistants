-spec single_number(Nums :: [integer()]) -> integer().
single_number(Nums) ->
    single_number(Nums, 0, 0, 0).

single_number([], _, Result, _) -> Result;
single_number([H | T], Bitmask1, Bitmask2, Bitmask3) ->
    NewBitmask1 = Bitmask1 band H,
    NewBitmask2 = Bitmask2 band NewBitmask1,
    NewBitmask3 = Bitmask3 band NewBitmask2,
    single_number(T, NewBitmask1, NewBitmask2, NewBitmask3).
