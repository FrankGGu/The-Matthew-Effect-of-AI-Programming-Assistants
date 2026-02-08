-module(solution).
-export([minimum_time_to_revert_word_to_initial_state/2]).

z_function(S) ->
    N = length(S),
    S_bin = list_to_binary(S), % Convert to binary for O(1) character access

    % Initialize Z-array as an Erlang array
    Z_array_init = array:new([{size, N}, {fixed, true}]),
    Z_array_with_Z0 = array:set(0, N, Z_array_init), % Z[0] = N

    z_loop(S_bin, N, 1, 0, 0, Z_array_with_Z0).

z_loop(_S_bin, N, I, _L, _R, Z_array) when I >= N ->
    array:to_list(Z_array); % Convert array to list for return
z_loop(S_bin, N, I, L, R, Z_array) ->
    ZI = if I =< R -> erlang:min(R - I + 1, array:get(I - L, Z_array)); true -> 0 end,

    CurrentZ = z_while(S_bin, N, I, ZI),

    NewZ_array = array:set(I, CurrentZ, Z_array),

    {NewL, NewR} = if I + CurrentZ - 1 > R -> {I, I + CurrentZ - 1}; true -> {L, R} end,

    z_loop(S_bin, N, I + 1, NewL, NewR, NewZ_array).

z_while(S_bin, N, I, CurrentZ) ->
    if
        I + CurrentZ < N andalso binary:at(S_bin, CurrentZ) == binary:at(S_bin, I + CurrentZ) ->
            z_while(S_bin, N, I, CurrentZ + 1);
        true ->
            CurrentZ
    end.

minimum_time_to_revert_word_to_initial_state(Word, K) ->
    N = length(Word),
    Z_list = z_function(Word),
    Z_array = array:from_list(Z_list), % Convert back to array for O(1) access in main loop

    find_min_time(N, K, Z_array, 1).

find_min_time(N, K, Z_array, T) ->
    Shift = T * K,

    if
        Shift >= N ->
            % If the shift is N or more, the remaining part (Word[Shift:]) is an empty string.
            % An empty string is considered a prefix of any string.
            % This is the first time the condition is met.
            T;
        true ->
            % The problem asks for the minimum time 't' such that
            % the word becomes a prefix of its initial state.
            % This is interpreted as: the suffix of the original word starting at index 'Shift'
            % must be equal to the prefix of the original word of length 'N - Shift'.
            % This is equivalent to Z[Shift] >= (N - Shift).
            RemainingLength = N - Shift,
            Z_val = array:get(Shift, Z_array),
            if
                Z_val >= RemainingLength ->
                    T;
                true ->
                    find_min_time(N, K, Z_array, T + 1)
            end
    end.