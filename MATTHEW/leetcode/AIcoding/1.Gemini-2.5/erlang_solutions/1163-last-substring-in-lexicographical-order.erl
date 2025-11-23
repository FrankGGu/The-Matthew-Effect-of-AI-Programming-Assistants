-module(solution).
-export([lastSubstring/1]).

lastSubstring(S) ->
    Bin = list_to_binary(S),
    N = byte_size(Bin),
    lastSubstring_impl(Bin, N, 0, 1, 0).

lastSubstring_impl(Bin, N, I, J, K) when J + K < N ->
    CharI_plus_K = binary:at(Bin, I + K),
    CharJ_plus_K = binary:at(Bin, J + K),

    if
        CharI_plus_K == CharJ_plus_K ->
            lastSubstring_impl(Bin, N, I, J, K + 1);
        CharI_plus_K < CharJ_plus_K ->
            lastSubstring_impl(Bin, N, J, J + 1, 0);
        true -> % CharI_plus_K > CharJ_plus_K
            lastSubstring_impl(Bin, N, I, J + K + 1, 0)
    end;
lastSubstring_impl(Bin, _N, I, _J, _K) ->
    binary_to_list(binary:part(Bin, I, byte_size(Bin) - I)).