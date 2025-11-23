-module(minimum_time_revert_word_initial_state_ii).
-export([minimum_time_revert_word_initial_state_ii/2]).

minimum_time_revert_word_initial_state_ii(Word, K) ->
    minimum_time_revert_word_initial_state_ii(Word, K, 0, 1).

minimum_time_revert_word_initial_state_ii(Word, K, Start, Time) ->
    Len = length(Word),

    case Start + K >= Len of
        true ->
            Time;
        false ->
            SubWord = lists:sublist(Word, Start + K + 1, Len - (Start + K)),
            case string:starts_with(SubWord, lists:sublist(Word, 1, Len - (Start + K))) of
                true ->
                    Time;
                false ->
                    minimum_time_revert_word_initial_state_ii(Word, K, Start + K, Time + 1)
            end
    end.