-module(max_frequency_stack).
-export([new/0, push/2, pop/1]).

new() ->
    {dict:new(), dict:new(), 0}.

push(Stack, Val) ->
    {FreqDict, MaxFreqDict, MaxFreq} = Stack,
    CurrentFreq = dict:fetch_val(Val, FreqDict, 0),
    NewFreq = CurrentFreq + 1,
    NewFreqDict = dict:store(Val, NewFreq, FreqDict),
    NewMaxFreqDict = dict:store(NewFreq, [Val | dict:fetch_val(NewFreq, MaxFreqDict, [])], MaxFreqDict),
    NewMaxFreq = max(MaxFreq, NewFreq),
    {NewFreqDict, NewMaxFreqDict, NewMaxFreq}.

pop(Stack) ->
    {FreqDict, MaxFreqDict, MaxFreq} = Stack,
    [TopVal | Rest] = dict:fetch_val(MaxFreq, MaxFreqDict, []),
    NewMaxFreqDict = dict:store(MaxFreq, Rest, MaxFreqDict),
    NewFreqDict = dict:store(TopVal, MaxFreq - 1, FreqDict),
    NewStack = {NewFreqDict, NewMaxFreqDict, MaxFreq},
    {TopVal, NewStack}.