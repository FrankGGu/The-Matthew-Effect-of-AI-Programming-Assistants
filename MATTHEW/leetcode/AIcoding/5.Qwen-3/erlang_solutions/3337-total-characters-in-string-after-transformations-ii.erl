-module(solution).
-export([number_of_characters/1]).

number_of_characters(S) ->
    number_of_characters(S, 0).

number_of_characters([], Acc) ->
    Acc;
number_of_characters([C | T], Acc) ->
    case C of
        $a -> number_of_characters(T, Acc + 1);
        $b -> number_of_characters(T, Acc + 2);
        $c -> number_of_characters(T, Acc + 3);
        $d -> number_of_characters(T, Acc + 4);
        $e -> number_of_characters(T, Acc + 5);
        $f -> number_of_characters(T, Acc + 6);
        $g -> number_of_characters(T, Acc + 7);
        $h -> number_of_characters(T, Acc + 8);
        $i -> number_of_characters(T, Acc + 9);
        $j -> number_of_characters(T, Acc + 10);
        $k -> number_of_characters(T, Acc + 11);
        $l -> number_of_characters(T, Acc + 12);
        $m -> number_of_characters(T, Acc + 13);
        $n -> number_of_characters(T, Acc + 14);
        $o -> number_of_characters(T, Acc + 15);
        $p -> number_of_characters(T, Acc + 16);
        $q -> number_of_characters(T, Acc + 17);
        $r -> number_of_characters(T, Acc + 18);
        $s -> number_of_characters(T, Acc + 19);
        $t -> number_of_characters(T, Acc + 20);
        $u -> number_of_characters(T, Acc + 21);
        $v -> number_of_characters(T, Acc + 22);
        $w -> number_of_characters(T, Acc + 23);
        $x -> number_of_characters(T, Acc + 24);
        $y -> number_of_characters(T, Acc + 25);
        $z -> number_of_characters(T, Acc + 26)
    end.