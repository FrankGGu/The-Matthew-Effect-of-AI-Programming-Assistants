-module(solution).
-export([min_space_wasted/2]).

min_space_wasted(Sizes, K) ->
    N = length(Sizes),
    SortedSizes = lists:sort(Sizes),
    Wasted = lists:duplicate(N+1, 0),
    MinWasted = lists:duplicate(N+1, infinity),
    MinWasted1 = lists:duplicate(N+1, infinity),
    MinWasted2 = lists:duplicate(N+1, infinity),
    min_space_wasted_helper(SortedSizes, 0, 0, N, K, Wasted, MinWasted1, MinWasted2).

min_space_wasted_helper(_, _, _, N, 0, Wasted, MinWasted, _) ->
    lists:min([MinWasted] ++ Wasted);
min_space_wasted_helper(SortedSizes, Start, Max, N, K, Wasted, MinWasted, Current) ->
    case Start >= N of
        true -> lists:min([MinWasted] ++ Wasted);
        false ->
            NewMax = lists:max([Max, lists:nth(Start + 1, SortedSizes)]),
            NewWasted = NewMax * (Start + 1) - lists:sum(lists:sublist(SortedSizes, 1, Start + 1)),
            NewMinWasted = lists:nth(Start, MinWasted) + NewWasted,
            MinWasted1 = lists:sublist(MinWasted, 0, K + 1),
            MinWasted2 = lists:sublist(MinWasted, 0, K),
            lists:foldl(fun (X, Acc) -> lists:append(Acc, [X + NewMinWasted]) end, [], lists:seq(0, K)) ++
            min_space_wasted_helper(SortedSizes, Start + 1, NewMax, N, K, 
                                    [NewWasted | Wasted], MinWasted1, MinWasted2)
    end.