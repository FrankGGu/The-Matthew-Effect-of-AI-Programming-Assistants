-spec move_zeroes(Nums :: [integer()]) -> [integer()].
move_zeroes(Nums) ->
    NonZeros = [X || X <- Nums, X =/= 0],
    Zeros = lists:duplicate(length(Nums) - length(NonZeros), 0),
    NonZeros ++ Zeros.