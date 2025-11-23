-module(solution).
-export([max_sum_distinct_subarrays_with_length_k/2]).

max_sum_distinct_subarrays_with_length_k(Nums, K) when K =< 0 -> 0;
max_sum_distinct_subarrays_with_length_k(Nums, K) ->
    Len = length(Nums),
    if
        Len < K -> 0;
        true ->
            % Initialize the first window
            InitialWindowList = lists:sublist(Nums, 1, K),
            {InitialSum, InitialFreqMap} = init_window_metrics(InitialWindowList),

            InitialMaxSum = if map_size(InitialFreqMap) == K -> InitialSum;
                               true -> 0
                            end,

            % Convert Nums to a tuple for O(1) element access during sliding
            NumsTuple = list_to_tuple(Nums),

            % Start sliding the window
            % CurrentPos represents the 1-based index of the element being added to the right of the window.
            % It starts at K + 1 (the element immediately after the initial window).
            slide_window(K, NumsTuple, K + 1, InitialSum, InitialFreqMap, InitialMaxSum)
    end.

init_window_metrics(WindowList) ->
    lists:foldl(fun(Num, {Sum, FreqMap}) ->
                        {Sum + Num, maps:update_with(Num, fun(Count) -> Count + 1 end, 1, FreqMap)}
                end, {0, #{}}, WindowList).

slide_window(K, NumsTuple, CurrentPos, CurrentSum, FreqMap, MaxSum) when CurrentPos > tuple_size(NumsTuple) ->
    MaxSum;
slide_window(K, NumsTuple, CurrentPos, CurrentSum, FreqMap, MaxSum) ->
    % Determine the element to remove from the left of the window
    % NumsTuple is 1-based, so LeftElement is at CurrentPos - K
    LeftElement = element(CurrentPos - K, NumsTuple),

    % Determine the element to add to the right of the window
    % RightElement is at CurrentPos
    RightElement = element(CurrentPos, NumsTuple),

    % Remove LeftElement from CurrentSum and FreqMap
    NewCurrentSum1 = CurrentSum - LeftElement,
    CountLeft = maps:get(LeftElement, FreqMap),
    NewFreqMap1 = if CountLeft == 1 -> maps:remove(LeftElement, FreqMap);
                     true -> maps:put(LeftElement, CountLeft - 1, FreqMap)
                  end,

    % Add RightElement to NewCurrentSum1 and NewFreqMap1
    NewCurrentSum2 = NewCurrentSum1 + RightElement,
    NewFreqMap2 = maps:update_with(RightElement, fun(Count) -> Count + 1 end, 1, NewFreqMap1),

    % Check if the new window has K distinct elements and update MaxSum
    UpdatedMaxSum = if map_size(NewFreqMap2) == K -> max(MaxSum, NewCurrentSum2);
                       true -> MaxSum
                    end,

    % Recurse for the next window
    slide_window(K, NumsTuple, CurrentPos + 1, NewCurrentSum2, NewFreqMap2, UpdatedMaxSum).