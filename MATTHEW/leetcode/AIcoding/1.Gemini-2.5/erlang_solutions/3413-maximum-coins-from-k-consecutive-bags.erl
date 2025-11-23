-module(solution).
-export([max_coins_k_bags/2]).

max_coins_k_bags(Coins, K) when K < 1 ->
    0;
max_coins_k_bags(Coins, K) when length(Coins) < K ->
    0;
max_coins_k_bags(Coins, K) ->
    % Initialize the first window
    {InitialWindowList, RestCoins} = lists:split(K, Coins),
    InitialSum = lists:sum(InitialWindowList),
    InitialQueue = queue:from_list(InitialWindowList),

    % Start sliding the window
    slide(RestCoins, InitialQueue, InitialSum, InitialSum).

slide([], _CurrentQueue, _CurrentSum, MaxSum) ->
    MaxSum;
slide([NewElement | RestCoins], CurrentQueue, CurrentSum, MaxSum) ->
    % Remove the oldest element from the front of the queue
    {value, OldestElement, QueueWithoutOldest} = queue:out(CurrentQueue),

    % Add the new element to the back of the queue
    NewQueue = queue:in(NewElement, QueueWithoutOldest),

    % Update the current sum for the new window
    NewSum = CurrentSum - OldestElement + NewElement,

    % Update the maximum sum found so far
    NewMaxSum = erlang:max(MaxSum, NewSum),

    % Recurse with the rest of the coins
    slide(RestCoins, NewQueue, NewSum, NewMaxSum).