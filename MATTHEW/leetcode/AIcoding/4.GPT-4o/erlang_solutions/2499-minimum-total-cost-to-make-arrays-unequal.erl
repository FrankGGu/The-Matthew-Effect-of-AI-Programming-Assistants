-module(solution).
-export([minimum_total_cost/2]).

minimum_total_cost(N, A) ->
    lists:foldl(fun(X, {M, C}) ->
        case lists:member(X, C) of
            true -> {M + 1, C};
            false -> {M, [X | C]}
        end
    end, {0, []}, A).