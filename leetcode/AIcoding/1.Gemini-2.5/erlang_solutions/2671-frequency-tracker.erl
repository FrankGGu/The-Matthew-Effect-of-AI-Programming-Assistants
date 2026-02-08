-module(frequency_tracker).
-export([new/0, add/2, delete_one/2, has_frequency/2]).

-record(state, {
    num_freqs = #{} :: #{integer() := integer()}, % number -> frequency
    freq_counts = #{} :: #{integer() := integer()} % frequency -> count of numbers with this frequency
}).

new() ->
    #state{}.

add(#state{num_freqs = NumFreqs, freq_counts = FreqCounts} = State, Num) ->
    OldFreq = maps:get(Num, NumFreqs, 0),
    NewFreq = OldFreq + 1,

    NewNumFreqs = maps:put(Num, NewFreq, NumFreqs),

    % Update FreqCounts: decrement count for OldFreq if it existed
    UpdatedFreqCounts1 =
        case OldFreq > 0 of
            true ->
                case maps:get(OldFreq, FreqCounts) of
                    1 -> maps:remove(OldFreq, FreqCounts);
                    Count -> maps:put(OldFreq, Count - 1, FreqCounts)
                end;
            false -> FreqCounts
        end,

    % Update FreqCounts: increment count for NewFreq
    NewFreqCounts = maps:update_with(NewFreq, fun(C) -> C + 1 end, 1, UpdatedFreqCounts1),

    State#state{num_freqs = NewNumFreqs, freq_counts = NewFreqCounts}.

delete_one(#state{num_freqs = NumFreqs, freq_counts = FreqCounts} = State, Num) ->
    case maps:get(Num, NumFreqs, 0) of
        0 -> % Num not present or freq is 0, do nothing
            State;
        OldFreq ->
            NewFreq = OldFreq - 1,

            NewNumFreqs =
                case NewFreq == 0 of
                    true -> maps:remove(Num, NumFreqs);
                    false -> maps:put(Num, NewFreq, NumFreqs)
                end,

            % Update FreqCounts: decrement count for OldFreq
            UpdatedFreqCounts1 =
                case maps:get(OldFreq, FreqCounts) of
                    1 -> maps:remove(OldFreq, FreqCounts);
                    Count -> maps:put(OldFreq, Count - 1, FreqCounts)
                end,

            % Update FreqCounts: increment count for NewFreq if it's positive
            NewFreqCounts =
                case NewFreq > 0 of
                    true -> maps:update_with(NewFreq, fun(C) -> C + 1 end, 1, UpdatedFreqCounts1);
                    false -> UpdatedFreqCounts1 % No new frequency to add if it's 0
                end,

            State#state{num_freqs = NewNumFreqs, freq_counts = NewFreqCounts}
    end.

has_frequency(#state{freq_counts = FreqCounts}, Freq) ->
    maps:is_key(Freq, FreqCounts).