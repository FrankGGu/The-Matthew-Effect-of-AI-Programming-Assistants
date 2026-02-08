-module(solution).
-export([count_arrangement/1]).

%% Helper function to count beautiful arrangements
-spec count_arrangement(N :: integer()) -> integer().
count_arrangement(N) ->
    count_arrangement(N, 1, 0, #{}).

%% Recursive backtracking function
-spec count_arrangement(N :: integer(), I :: integer(), Count :: integer(), Used :: map()) -> integer().
count_arrangement(N, I, Count, Used) when I > N ->
    Count + 1;

count_arrangement(N, I, Count, Used) ->
    lists:foldl(fun(X, Acc) ->
                    case maps:get(X, Used) of
                        undefined when (X rem I == 0; I rem X == 0) ->
                            count_arrangement(N, I + 1, Acc + 1, maps:put(X, true, Used));
                        _ -> Acc
                    end
                end, Count, lists:seq(1, N)).

