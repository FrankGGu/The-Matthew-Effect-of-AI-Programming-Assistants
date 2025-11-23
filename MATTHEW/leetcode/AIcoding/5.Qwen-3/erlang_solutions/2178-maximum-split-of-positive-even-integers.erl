-module(maximum_split_of_positive_even_integers).
-export([splitEvenNumber/1]).

splitEvenNumber(N) ->
    splitEvenNumber(N, []).

splitEvenNumber(0, Acc) ->
    lists:reverse(Acc);
splitEvenNumber(N, Acc) ->
    Max = min(N - 2, 2),
    splitEvenNumber(N - Max, [Max | Acc]).