-module(solution).
-export([find_good_subset/1]).

find_good_subset(Matrix) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    find_subset(Matrix, N, M).

find_subset(Matrix, N, M) ->
    case find_good_subset_helper(Matrix, N, M, 0, []) of
        {ok, Subset} -> Subset;
        _ -> []
    end.

find_good_subset_helper(_, N, M, Index, Subset) when Index >= N -> 
    {ok, Subset};
find_good_subset_helper(Matrix, N, M, Index, Subset) ->
    NewSubset = lists:filter(fun(Row) -> lists:nth(Index + 1, Row) =:= 1 end, Matrix),
    find_good_subset_helper(Matrix, N, M, Index + 1, NewSubset).