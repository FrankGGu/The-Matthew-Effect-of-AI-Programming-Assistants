-module(frequency_tracker).
-export([new/0, add/2, delete/2, has_freq/1]).

new() ->
    {dict:new(), dict:new()}.

add(Item, State) ->
    {Items, Frequencies} = State,
    CurrentFreq = dict:fetch(Item, Items, 0),
    NewItems = dict:store(Item, CurrentFreq + 1, Items),
    NewFrequencies = dict:store(CurrentFreq + 1, 1 + dict:fetch(CurrentFreq + 1, Frequencies, 0), Frequencies),
    {NewItems, NewFrequencies}.

delete(Item, State) ->
    {Items, Frequencies} = State,
    CurrentFreq = dict:fetch(Item, Items, 0),
    if
        CurrentFreq == 0 ->
            State;
        true ->
            NewItems = dict:store(Item, CurrentFreq - 1, Items),
            NewFrequencies = dict:store(CurrentFreq, (dict:fetch(CurrentFreq, Frequencies, 0) - 1), Frequencies),
            if
                dict:fetch(CurrentFreq, NewFrequencies, 0) == 0 ->
                    NewFrequencies1 = dict:erase(CurrentFreq, NewFrequencies);
                true ->
                    NewFrequencies1 = NewFrequencies
            end,
            if
                CurrentFreq - 1 == 0 ->
                    NewItems1 = dict:erase(Item, NewItems);
                true ->
                    NewItems1 = NewItems
            end,
            {NewItems1, NewFrequencies1}
    end.

has_freq(Freq, State) ->
    {_, Frequencies} = State,
    case dict:find(Freq, Frequencies) of
        {ok, _} -> true;
        error -> false
    end.

has_freq(Freq) ->
    has_freq(Freq, new()).