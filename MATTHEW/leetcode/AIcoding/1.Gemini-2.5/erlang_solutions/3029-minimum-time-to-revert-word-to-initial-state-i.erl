-module(solution).
-export([minimum_time_to_revert_word_to_initial_state/2]).

minimum_time_to_revert_word_to_initial_state(Word, K) ->
    WordArr = array:from_list(string:to_list(Word)),
    N = array:size(WordArr),
    ZArray = build_z_array(WordArr, N),
    solve(ZArray, N, K, 1).

solve(ZArray, N, K, T) ->
    J = T * K,
    if J >= N ->
        T;
    true ->
        ExpectedLength = N - J,
        ActualZLength = array:get(J, ZArray),
        if ActualZLength == ExpectedLength ->
            T;
        true ->
            solve(ZArray, N, K, T + 1)
        end
    end.

build_z_array(SArr, N) ->
    Z = array:new([{fixed, true}, {size, N}]),
    Z1 = array:set(0, N, Z),
    build_z_array_loop(SArr, N, Z1, 1, 0, 0).

build_z_array_loop(SArr, N, Z, I, L, R) when I < N ->
    CurrentZ = if I > R ->
                    calculate_z_match_loop(SArr, N, I, 0);
                true ->
                    K = I - L,
                    if array:get(K, Z) < R - I + 1 ->
                        array:get(K, Z);
                    true ->
                        calculate_z_match_loop(SArr, N, I, R - I + 1)
                    end
                end,

    NewZ = array:set(I, CurrentZ, Z),

    {NewL, NewR} = if I + CurrentZ - 1 > R ->
                       {I, I + CurrentZ - 1};
                   true ->
                       {L, R}
                   end,

    build_z_array_loop(SArr, N, NewZ, I + 1, NewL, NewR);
build_z_array_loop(_, _, Z, _, _, _) ->
    Z.

calculate_z_match_loop(SArr, N, StartIdx, CurrentMatchLength) ->
    Idx1 = CurrentMatchLength,
    Idx2 = StartIdx + CurrentMatchLength,
    if Idx2 < N andalso Idx1 < N andalso array:get(Idx1, SArr) == array:get(Idx2, SArr) ->
        calculate_z_match_loop(SArr, N, StartIdx, CurrentMatchLength + 1);
    true ->
        CurrentMatchLength
    end.