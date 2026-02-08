-module(prime_in_diagonal).
-export([diagonalPrime/1]).

diagonalPrime(Mat) ->
  N = length(Mat),
  findMaxPrime(Mat, N, 0, -1).

findMaxPrime(_Mat, _N, I, Max) when I >= _N ->
  Max;
findMaxPrime(Mat, N, I, Max) ->
  Val1 = lists:nth(I + 1, lists:nth(I + 1, Mat)),
  Val2 = lists:nth(N - I, lists:nth(I + 1, Mat)),

  NewMax1 = case isPrime(Val1) of
    true -> max(Max, Val1);
    false -> Max
  end,

  NewMax2 = case (N - I - 1) =/= I andalso isPrime(Val2) of
    true -> max(NewMax1, Val2);
    false -> NewMax1
  end,

  findMaxPrime(Mat, N, I + 1, NewMax2).

isPrime(Num) when Num < 2 ->
  false;
isPrime(Num) ->
  isPrimeHelper(Num, 2).

isPrimeHelper(Num, I) when I * I > Num ->
  true;
isPrimeHelper(Num, I) when Num rem I == 0 ->
  false;
isPrimeHelper(Num, I) ->
  isPrimeHelper(Num, I + 1).