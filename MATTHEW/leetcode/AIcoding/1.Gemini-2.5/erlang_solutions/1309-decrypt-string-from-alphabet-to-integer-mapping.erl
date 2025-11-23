-module(solution).
-export([freqAlphabets/1]).

freqAlphabets(S) ->
    lists:reverse(decrypt_helper(S, [])).

decrypt_helper([D1, D2, $# | Rest], Acc) ->
    Num = list_to_integer([D1, D2]),
    Char = $a + Num - 1,
    decrypt_helper(Rest, [Char | Acc]);
decrypt_helper([D | Rest], Acc) ->
    Num = list_to_integer([D]),
    Char = $a + Num - 1,
    decrypt_helper(Rest, [Char | Acc]);
decrypt_helper([], Acc) ->
    Acc.