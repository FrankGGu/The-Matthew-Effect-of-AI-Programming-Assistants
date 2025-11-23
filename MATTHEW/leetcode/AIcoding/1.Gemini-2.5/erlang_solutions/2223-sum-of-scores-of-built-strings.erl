-module(solution).
-export([sum_scores/1]).

sum_scores(S) ->
    N = byte_size(S),
    Z = calculate_z_array(S, N),
    lists:sum(Z).

calculate_z_array(S, N) ->
    calculate_z_array_map_impl(1, 0, 0, #{0 => N}, S, N).

calculate_z_array_map_impl(I, L, R, ZMap, S, N) when I < N ->
    Z_i = 0,
    NewL = L,
    NewR = R,

    if I =< R ->
        K = I - L,
        Z_k = maps:get(K, ZMap),
        RemainingInZBox = R - I + 1,
        if Z_k < RemainingInZBox ->
            Z_i = Z_k;
        true ->
            MatchLenExtension = extend_match(S, RemainingInZBox, I + RemainingInZBox, N),
            Z_i = RemainingInZBox + MatchLenExtension,
            NewL = I,
            NewR = I + Z_i - 1
        end;
    true ->
        MatchLen = extend_match(S, 0, I, N),
        Z_i = MatchLen,
        NewL = I,
        NewR = I + Z_i - 1
    end,

    NewZMap = ZMap#{I => Z_i},
    calculate_z_array_map_impl(I + 1, NewL, NewR, NewZMap, S, N);
calculate_z_array_map_impl(N, _L, _R, ZMap, _S, _N) ->
    [maps:get(Idx, ZMap) || Idx <- lists:seq(0, N-1)].

extend_match(S, PrefixOffset, StringOffset, N) ->
    extend_match_recursive(S, PrefixOffset, StringOffset, 0, N).

extend_match_recursive(S, PrefixIdx, StringIdx, CurrentMatchLen, N) when
    StringIdx + CurrentMatchLen < N andalso
    PrefixIdx + CurrentMatchLen < N andalso
    binary:at(S, PrefixIdx + CurrentMatchLen) == binary:at(S, StringIdx + CurrentMatchLen) ->
    extend_match_recursive(S, PrefixIdx, StringIdx, CurrentMatchLen + 1, N);
extend_match_recursive(_S, _PrefixIdx, _StringIdx, CurrentMatchLen, _N) ->
    CurrentMatchLen.