-module(solution).
-export([minimum_time_to_revert_word_to_initial_state/2]).

minimum_time_to_revert_word_to_initial_state(Word, K) ->
    N = length(Word),
    Prefix = lists:sublist(Word, K),
    Suffix = lists:nthtail(N - K, Word),
    if
        Prefix =:= Suffix -> 1;
        true -> 1 + minimum_time_to_revert_word_to_initial_state(lists:sublist(Word, N - K) ++ Prefix, K)
    end.