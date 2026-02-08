-module(solution).
-export([min_increments/1]).

min_increments(Nums) ->
    lists:foldl(fun(X, {Set, Count}) ->
        case sets:is_element(X, Set) of
            true ->
                NewX = find_next_unique(X, Set),
                {sets:add_element(NewX, Set), Count + (NewX - X)};
            false ->
                {sets:add_element(X, Set), Count}
        end
    end, {sets:new(), 0}, Nums).

find_next_unique(X, Set) ->
    case sets:is_element(X, Set) of
        true -> find_next_unique(X + 1, Set);
        false -> X
    end.