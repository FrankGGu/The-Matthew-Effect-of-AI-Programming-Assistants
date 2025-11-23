-module(solution).
-export([countNumbersWithUniqueDigits/1]).

countNumbersWithUniqueDigits(0) -> 1;
countNumbersWithUniqueDigits(N) when N > 0 ->
    Ans = 10,
    Product = 9,
    AvailableDigits = 9,
    count_recursive(N, 2, Ans, Product, AvailableDigits).

count_recursive(N, CurrentLength, Ans, Product, AvailableDigits) when CurrentLength > N ->
    Ans;
count_recursive(N, CurrentLength, Ans, Product, AvailableDigits) ->
    NewProduct = Product * AvailableDigits,
    NewAns = Ans + NewProduct,
    NewAvailableDigits = AvailableDigits - 1,
    count_recursive(N, CurrentLength + 1, NewAns, NewProduct, NewAvailableDigits).