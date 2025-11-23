-module(solution).
-export([number_of_lines/1]).

number_of_lines(Chars) ->
    lists:foldl(fun(Char, {Lines, Width}) ->
                    Case = case Char of
                               $a -> 1;
                               $b -> 2;
                               $c -> 3;
                               $d -> 4;
                               $e -> 5;
                               $f -> 6;
                               $g -> 7;
                               $h -> 8;
                               $i -> 9;
                               $j -> 10;
                               $k -> 11;
                               $l -> 12;
                               $m -> 13;
                               $n -> 14;
                               $o -> 15;
                               $p -> 16;
                               $q -> 17;
                               $r -> 18;
                               $s -> 19;
                               $t -> 20;
                               $u -> 21;
                               $v -> 22;
                               $w -> 23;
                               $x -> 24;
                               $y -> 25;
                               $z -> 26;
                               _ -> 0
                           end,
                    if
                        Case == 0 -> {Lines, Width};
                        true ->
                            if
                                Width + Case > 100 ->
                                    {Lines + 1, Case};
                                true ->
                                    {Lines, Width + Case}
                            end
                    end
                end, {0, 0}, Chars).