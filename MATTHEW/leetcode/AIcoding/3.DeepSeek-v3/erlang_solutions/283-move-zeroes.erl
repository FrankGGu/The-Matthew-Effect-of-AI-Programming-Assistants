-spec move_zeroes(Nums :: [integer()]) -> [integer()].
move_zeroes(Nums) ->
    NonZeros = [X || X <- Nums, X =/= 0],
    Zeros = [0 || _ <- lists:seq(1, length(Nums) - length(NonZeros)],
    NonZeros ++ Zeros.