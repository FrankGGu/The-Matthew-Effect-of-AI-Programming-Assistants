-module(reverse_degree_of_a_string).
-export([reverse_degree/1]).

reverse_degree(Str) ->
    reverse_degree(Str, 0, 0).

reverse_degree([], _, Acc) ->
    Acc;
reverse_degree([H | T], Pos, Acc) ->
    case H of
        $a -> reverse_degree(T, Pos + 1, Acc + 1);
        $b -> reverse_degree(T, Pos + 1, Acc + 2);
        $c -> reverse_degree(T, Pos + 1, Acc + 3);
        $d -> reverse_degree(T, Pos + 1, Acc + 4);
        $e -> reverse_degree(T, Pos + 1, Acc + 5);
        $f -> reverse_degree(T, Pos + 1, Acc + 6);
        $g -> reverse_degree(T, Pos + 1, Acc + 7);
        $h -> reverse_degree(T, Pos + 1, Acc + 8);
        $i -> reverse_degree(T, Pos + 1, Acc + 9);
        $j -> reverse_degree(T, Pos + 1, Acc + 10);
        $k -> reverse_degree(T, Pos + 1, Acc + 11);
        $l -> reverse_degree(T, Pos + 1, Acc + 12);
        $m -> reverse_degree(T, Pos + 1, Acc + 13);
        $n -> reverse_degree(T, Pos + 1, Acc + 14);
        $o -> reverse_degree(T, Pos + 1, Acc + 15);
        $p -> reverse_degree(T, Pos + 1, Acc + 16);
        $q -> reverse_degree(T, Pos + 1, Acc + 17);
        $r -> reverse_degree(T, Pos + 1, Acc + 18);
        $s -> reverse_degree(T, Pos + 1, Acc + 19);
        $t -> reverse_degree(T, Pos + 1, Acc + 20);
        $u -> reverse_degree(T, Pos + 1, Acc + 21);
        $v -> reverse_degree(T, Pos + 1, Acc + 22);
        $w -> reverse_degree(T, Pos + 1, Acc + 23);
        $x -> reverse_degree(T, Pos + 1, Acc + 24);
        $y -> reverse_degree(T, Pos + 1, Acc + 25);
        $z -> reverse_degree(T, Pos + 1, Acc + 26);
        _ -> reverse_degree(T, Pos + 1, Acc)
    end.