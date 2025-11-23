-module(solution).
-export([find_losers_of_the_circular_game/2]).

find_losers_of_the_circular_game(N, K) ->
    Received = sets:new(),
    CurrentFriend = 1,
    InitialReceived = sets:add_element(CurrentFriend, Received),

    FinalReceivedSet = simulate_game(N, K, CurrentFriend, InitialReceived),

    AllFriends = lists:seq(1, N),
    Losers = [Friend || Friend <- AllFriends, not sets:is_element(Friend, FinalReceivedSet)],
    Losers.

simulate_game(N, K, CurrentFriend, Received) ->
    NextFriend = (CurrentFriend - 1 + K) rem N + 1,

    if sets:is_element(NextFriend, Received) ->
        Received;
    else
        simulate_game(N, K, NextFriend, sets:add_element(NextFriend, Received))
    end.