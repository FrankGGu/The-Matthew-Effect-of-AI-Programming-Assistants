-module(solution).
-export([num_times_all_blue/1]).

num_times_all_blue(Flips) ->
    num_times_all_blue_impl(Flips, 0, 0, 0).

num_times_all_blue_impl([], _MaxFlipped, _NumFlips, Count) ->
    Count;
num_times_all_blue_impl([FlipValue | Rest], MaxFlipped, NumFlips, Count) ->
    NewMaxFlipped = max(MaxFlipped, FlipValue),
    NewNumFlips = NumFlips + 1,
    NewCount = if
                   NewMaxFlipped == NewNumFlips - 1 ->
                       Count + 1;
                   true ->
                       Count
               end,
    num_times_all_blue_impl(Rest, NewMaxFlipped, NewNumFlips, NewCount).