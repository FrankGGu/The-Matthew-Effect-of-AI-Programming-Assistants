-module(solution).
-export([min_operations/2]).

min_operations(Array, K) ->
    Sorted = lists:sort(Array),
    N = length(Sorted),
    Median = if N rem 2 == 1 -> lists:nth((N div 2) + 1, Sorted);
              true -> (lists:nth(N div 2, Sorted) + lists:nth((N div 2) + 1, Sorted)) div 2
             end,
    case Median of
        K -> 0;
        _ -> lists:sum(lists:map(fun X -> abs(X - K) end, Sorted))
    end.