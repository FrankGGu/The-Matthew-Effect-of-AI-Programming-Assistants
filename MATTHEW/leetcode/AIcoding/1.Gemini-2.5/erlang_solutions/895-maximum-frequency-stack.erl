-module(freq_stack).
-export([new/0, push/2, pop/1]).

-record(state, {
    freq_map = #{} :: #{integer() => integer()}, % element -> frequency
    freq_stacks = #{} :: #{integer() => [integer()]}, % frequency -> list of elements (stack, most recent at head)
    max_freq = 0 :: integer()
}).

new() ->
    #state{}.

push(Val, #state{freq_map = FreqMap, freq_stacks = FreqStacks, max_freq = MaxFreq} = State) ->
    OldFreq = maps:get(Val, FreqMap, 0),
    NewFreq = OldFreq + 1,

    NewFreqMap = maps:put(Val, NewFreq, FreqMap),

    NewFreqStack = [Val | maps:get(NewFreq, FreqStacks, [])],
    NewFreqStacks = maps:put(NewFreq, NewFreqStack, FreqStacks),

    NewMaxFreq = max(MaxFreq, NewFreq),

    State#state{freq_map = NewFreqMap, freq_stacks = NewFreqStacks, max_freq = NewMaxFreq}.

pop(#state{freq_map = FreqMap, freq_stacks = FreqStacks, max_freq = MaxFreq} = State) ->
    {PoppedVal, UpdatedFreqStacks, UpdatedMaxFreq} = 
        find_and_remove_from_max_freq_stack(MaxFreq, FreqMap, FreqStacks),

    OldPoppedValFreq = maps:get(PoppedVal, FreqMap),
    NewPoppedValFreq = OldPoppedValFreq - 1,

    NewFreqMap = 
        if
            NewPoppedValFreq == 0 -> maps:remove(PoppedVal, FreqMap);
            true -> maps:put(PoppedVal, NewPoppedValFreq, FMap)
        end,

    {PoppedVal, State#state{freq_map = NewFreqMap, freq_stacks = UpdatedFreqStacks, max_freq = UpdatedMaxFreq}}.

find_and_remove_from_max_freq_stack(CurrentMaxFreq, FreqMap, FreqStacks) ->
    MaxFreqStack = maps:get(CurrentMaxFreq, FreqStacks),
    PoppedValCandidate = hd(MaxFreqStack),
    CurrentFreqOfCandidate = maps:get(PoppedValCandidate, FMap),

    if
        CurrentFreqOfCandidate == CurrentMaxFreq ->
            NewMaxFreqStack = tl(MaxFreqStack),
            NewFreqStacks = 
                if
                    NewMaxFreqStack == [] -> maps:remove(CurrentMaxFreq, FreqStacks);
                    true -> maps:put(CurrentMaxFreq, NewMaxFreqStack, FreqStacks)
                end,
            NewMaxFreq = 
                if
                    NewMaxFreqStack == [] -> CurrentMaxFreq - 1;
                    true -> CurrentMaxFreq
                end,
            {PoppedValCandidate, NewFreqStacks, NewMaxFreq};
        true ->
            NewMaxFreqStack = tl(MaxFreqStack),
            TempFreqStacks = 
                if
                    NewMaxFreqStack == [] -> maps:remove(CurrentMaxFreq, FreqStacks);
                    true -> maps:put(CurrentMaxFreq, NewMaxFreqStack, FreqStacks)
                end,
            TempMaxFreq = 
                if
                    NewMaxFreqStack == [] -> CurrentMaxFreq - 1;
                    true -> CurrentMaxFreq
                end,
            find_and_remove_from_max_freq_stack(TempMaxFreq, FreqMap, TempFreqStacks)
    end.