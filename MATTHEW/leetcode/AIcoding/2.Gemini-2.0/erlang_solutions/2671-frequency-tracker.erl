-module(frequency_tracker).

-export([start/0, add/2, deleteOne/2, hasFrequency/2]).

start() ->
    dict:new().

add(Tracker, number) ->
    Frequency = case dict:find(number, Tracker) of
                    {ok, F} -> F + 1;
                    error -> 1
                end,
    dict:store(number, Frequency, Tracker).

deleteOne(Tracker, number) ->
    case dict:find(number, Tracker) of
        {ok, 1} ->
            dict:erase(number, Tracker);
        {ok, Frequency} ->
            dict:store(number, Frequency - 1, Tracker);
        error ->
            Tracker
    end.

hasFrequency(Tracker, frequency) ->
    Values = dict:values(Tracker),
    lists:member(frequency, Values).