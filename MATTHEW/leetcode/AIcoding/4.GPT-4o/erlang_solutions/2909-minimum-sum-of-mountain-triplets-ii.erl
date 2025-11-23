-module(solution).
-export([minimum_sum_of_triplets/1]).

minimum_sum_of_triplets(Mountain) ->
    N = length(Mountain),
    Triples = lists:sublist(Mountain, N - 2),
    MinSum = lists:min(lists:map(fun({A, B, C}) -> A + B + C end,
        lists:zip3(Triples, lists:tl(Triples), lists:tl(lists:tl(Triples))))),
    MinSum.