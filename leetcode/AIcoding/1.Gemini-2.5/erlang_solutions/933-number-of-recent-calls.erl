-module(recent_counter).
-export([new/0, ping/2]).

-type recent_counter_state() :: [integer()].

new() ->
    [].

ping(State, T) ->
    Threshold = T - 3000,
    NewStateWithT = lists:append(State, [T]),
    FilteredState = lists:dropwhile(fun(X) -> X < Threshold end, NewStateWithT),
    Count = length(FilteredState),
    {Count, FilteredState}.