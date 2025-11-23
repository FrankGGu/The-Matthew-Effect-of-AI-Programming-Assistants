-module(solution).
-export([total_hamming_distance/1]).

-spec total_hamming_distance([integer()]) -> integer().
total_hamming_distance(Nums) ->
    % Get the total length of the list
    N = length(Nums),
    % Initialize the result to 0
    lists:foldl(fun(_, Acc) -> Acc end, 0, lists:seq(0, 30)).

