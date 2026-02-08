-module(solution).
-export([arithmeticTriplets/2]).

arithmeticTriplets(Keys, diff) ->
    Triples = lists:foldl(fun(X, Acc) ->
        case lists:member(X + diff, Keys) andalso lists:member(X + 2 * diff, Keys) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Keys),
    Triples.