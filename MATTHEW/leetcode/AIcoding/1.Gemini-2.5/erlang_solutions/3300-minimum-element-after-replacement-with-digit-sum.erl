-module(solution).
-export([minimum_element_after_replacement/1]).

minimum_element_after_replacement(Nums) ->
    TransformedNums = lists:map(fun digital_root/1, Nums),
    lists:min(TransformedNums).

digital_root(N) when N > 0 ->
    1 + (N - 1) rem 9;
digital_root(0) ->
    0.