-module(solution).
-export([median_sliding_window/2]).

-define(MAX_SIZE, 100000).

%% This function calculates the median for each sliding window.
-spec median_sliding_window([integer()], integer()) -> [float()].
median_sliding_window(Nums, K) ->
    SlidingWindow = lists:split(K, Nums),
    lists:map(fun(Window) -> median(Window) end, SlidingWindow).

%% This function calculates the median of a sorted list.
-spec median([integer()]) -> float().
median(Window) ->
    SortedWindow = lists:sort(Window),
    N = length(SortedWindow),
    case N rem 2 of
        0 -> 
            %% Even number of elements: average of the two middle numbers
            (hd(tl(SortedWindow)) + hd(tl(tl(SortedWindow)))) / 2;
        _ -> 
            %% Odd number of elements: return the middle number
            hd(tl(tl(SortedWindow)))
    end.

%% Helper function to split the window across the array.
lists:split(K, List) ->
    %% Return a sliding window of size K.
    %% This will generate a new list containing a list for each window.
    lists:map(fun(L) -> lists:sublist(L, K) end, lists:seq(1, length(List))).

