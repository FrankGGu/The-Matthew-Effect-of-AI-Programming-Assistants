-module(solution).
-export([minimized_maximum/2]).

minimized_maximum(N, Quantities) ->
    MaxQ = lists:max(Quantities),
    binary_search(1, MaxQ, N, Quantities, MaxQ).

binary_search(Low, High, N, Quantities, Ans) ->
    if
        Low > High -> Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            if
                check(Mid, N, Quantities) ->
                    binary_search(Low, Mid - 1, N, Quantities, Mid);
                true ->
                    binary_search(Mid + 1, High, N, Quantities, Ans)
            end
    end.

check(MaxProductsPerStore, N, Quantities) ->
    RequiredStores = lists:sum([ (Q + MaxProductsPerStore - 1) div MaxProductsPerStore || Q <- Quantities ]),
    RequiredStores =< N.