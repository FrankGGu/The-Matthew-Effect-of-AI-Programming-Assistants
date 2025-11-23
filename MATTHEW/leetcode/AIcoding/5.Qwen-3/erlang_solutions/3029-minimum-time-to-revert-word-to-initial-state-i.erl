-module(solution).
-export([minimum_time_to_revert_word_to_initial_state/1]).

minimum_time_to_revert_word_to_initial_state(W) ->
    N = length(W),
    K = 0,
    minimum_time_to_revert_word_to_initial_state(W, N, K).

minimum_time_to_revert_word_to_initial_state(W, N, K) ->
    case K of
        _ when K >= N -> K;
        _ ->
            Prefix = lists:sublist(W, K),
            Suffix = lists:sublist(W, N - K, N),
            if
                Prefix == Suffix -> K;
                true -> minimum_time_to_revert_word_to_initial_state(W, N, K + 1)
            end
    end.