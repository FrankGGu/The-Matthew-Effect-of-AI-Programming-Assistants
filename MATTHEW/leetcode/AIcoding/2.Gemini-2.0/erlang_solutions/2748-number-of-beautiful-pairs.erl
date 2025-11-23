-module(number_of_beautiful_pairs).
-export([countBeautifulPairs/1]).

countBeautifulPairs(Nums) ->
    countBeautifulPairs(Nums, 0).

countBeautifulPairs([], Acc) ->
    Acc;
countBeautifulPairs([H|T], Acc) ->
    Acc1 = countBeautifulPairs(T, Acc),
    Acc2 = countBeautifulPairsWithHead(H, T, Acc1),
    Acc2.

countBeautifulPairsWithHead(_, [], Acc) ->
    Acc;
countBeautifulPairsWithHead(H, [H2|T], Acc) ->
    Acc1 = case gcd(firstDigit(H), H2) == 1 andalso gcd(firstDigit(H2), H) == 1 of
        true -> Acc + 1;
        false -> Acc
    end,
    countBeautifulPairsWithHead(H, T, Acc1).

firstDigit(N) ->
    firstDigit(N, 10).

firstDigit(N, Div) ->
    case N < Div of
        true -> N;
        false -> firstDigit(N div Div, Div * 10)
    end.

gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).