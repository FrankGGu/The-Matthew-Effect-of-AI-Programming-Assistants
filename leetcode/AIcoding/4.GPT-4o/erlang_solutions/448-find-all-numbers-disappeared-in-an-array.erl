-module(solution).
-export([find_disappeared_numbers/1]).

-spec find_disappeared_numbers([integer()]) -> [integer()].
find_disappeared_numbers(Nums) ->
    N = length(Nums),
    %% Mark the positions of numbers that are present in the array
    lists:foldl(fun(N, Acc) ->
                    idx = abs(N) - 1,
                    case lists:member(idx, Acc) of
                        true -> Acc;
                        false -> [idx | Acc]
                    end
                end, [], Nums).
