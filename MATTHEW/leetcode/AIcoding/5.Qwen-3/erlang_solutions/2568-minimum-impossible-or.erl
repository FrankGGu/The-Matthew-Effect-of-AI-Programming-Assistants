-module(minimum_impossible_or).
-export([minImpossibleOR/1]).

minImpossibleOR(Nums) ->
    S = sets:from_list(Nums),
    N = length(Nums),
    find_min(S, 1).

find_min(S, X) ->
    case sets:is_element(X, S) of
        true -> find_min(S, X * 2);
        false -> X
    end.