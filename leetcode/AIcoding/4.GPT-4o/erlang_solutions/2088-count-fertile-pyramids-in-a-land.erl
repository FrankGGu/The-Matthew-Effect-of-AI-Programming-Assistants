-module(solution).
-export([count_pyramids/1]).

count_pyramids(L) ->
    N = length(L),
    count_pyramids_helper(L, N, 0).

count_pyramids_helper(_, 0, Count) ->
    Count;
count_pyramids_helper(L, N, Count) ->
    NewCount = Count + count_pyramids_at_level(L, N),
    count_pyramids_helper(L, N - 1, NewCount).

count_pyramids_at_level(L, N) ->
    case N of
        0 -> 0;
        _ -> lists:foldl(fun({X, Y}, Acc) -> 
                        Acc + (X * Y)
                    end, 0, lists:zip(L, lists:duplicate(N, 1)))
    end.