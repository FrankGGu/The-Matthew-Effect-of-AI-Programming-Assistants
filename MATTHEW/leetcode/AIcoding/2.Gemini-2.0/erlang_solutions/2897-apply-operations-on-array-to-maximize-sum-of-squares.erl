-module(apply_operations_on_array_to_maximize_sum_of_squares).
-export([maximum_sum_of_squares/2]).

maximum_sum_of_squares(Nums, K) ->
    Zeros = lists:filter(fun(X) -> X == 0 end, Nums),
    Ones = lists:filter(fun(X) -> X == 1 end, Nums),
    Twos = lists:filter(fun(X) -> X == 2 end, Nums),
    ZeroCount = length(Zeros),
    OneCount = length(Ones),
    TwoCount = length(Twos),

    OneToAdd = min(K, ZeroCount),
    NewOnes = OneCount + OneToAdd,
    RemainingK = K - OneToAdd,
    NewZeros = ZeroCount - OneToAdd,

    TwoToAdd = min(RemainingK, NewZeros),
    NewTwos = TwoCount + TwoToAdd,
    NewZeros2 = NewZeros - TwoToAdd,

    RepOnes = lists:duplicate(NewOnes, 1),
    RepTwos = lists:duplicate(NewTwos, 2),
    RepZeros = lists:duplicate(NewZeros2, 0),

    NewArray = RepTwos ++ RepOnes ++ RepZeros,

    SumOfSquares = lists:sum([X*X || X <- NewArray]),
    SumOfSquares.