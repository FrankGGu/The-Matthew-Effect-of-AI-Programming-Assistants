-module(decrypt_string).
-export([freq_map/1]).

freq_map(Str) ->
    decrypt(Str, []).

decrypt([], Acc) -> 
    lists:reverse(Acc);
decrypt([H|T], Acc) ->
    case H of
        $1 -> decrypt(T, [1 | Acc]);
        $2 -> decrypt(T, [2 | Acc]);
        $3 -> decrypt(T, [3 | Acc]);
        $4 -> decrypt(T, [4 | Acc]);
        $5 -> decrypt(T, [5 | Acc]);
        $6 -> decrypt(T, [6 | Acc]);
        $7 -> decrypt(T, [7 | Acc]);
        $8 -> decrypt(T, [8 | Acc]);
        $9 -> decrypt(T, [9 | Acc]);
        $a -> decrypt(T, [10 | Acc]);
        $b -> decrypt(T, [11 | Acc]);
        $c -> decrypt(T, [12 | Acc]);
        $d -> decrypt(T, [13 | Acc]);
        $e -> decrypt(T, [14 | Acc]);
        $f -> decrypt(T, [15 | Acc]);
        $g -> decrypt(T, [16 | Acc]);
        $h -> decrypt(T, [17 | Acc]);
        $i -> decrypt(T, [18 | Acc]);
        $j -> decrypt(T, [19 | Acc]);
        $k -> decrypt(T, [20 | Acc]);
        $l -> decrypt(T, [21 | Acc]);
        $m -> decrypt(T, [22 | Acc]);
        $n -> decrypt(T, [23 | Acc]);
        $o -> decrypt(T, [24 | Acc]);
        $p -> decrypt(T, [25 | Acc]);
        $q -> decrypt(T, [26 | Acc]);
        _ -> decrypt(T, Acc)
    end.