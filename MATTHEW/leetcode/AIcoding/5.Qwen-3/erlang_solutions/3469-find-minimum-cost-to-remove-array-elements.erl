-module(solution).
-export([min_cost/1]).

min_cost(Nums) ->
    min_cost(Nums, 0, 0, 0).

min_cost([], _, _, Cost) ->
    Cost;
min_cost([H | T], Index, Count, Cost) ->
    if
        Count == 0 ->
            min_cost(T, Index + 1, Count + 1, Cost + H);
        true ->
            case (Index rem 2) of
                0 ->
                    min_cost(T, Index + 1, Count + 1, Cost + H);
                _ ->
                    min_cost(T, Index + 1, Count + 1, Cost)
            end
    end.