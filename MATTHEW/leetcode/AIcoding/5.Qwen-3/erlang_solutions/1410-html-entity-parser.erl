-module(html_entity_parser).
-export([entity_parser/1]).

entity_parser(Str) ->
    entity_parser(Str, [], 0).

entity_parser([], Acc, _) ->
    lists:reverse(Acc);
entity_parser([C | Rest], Acc, State) ->
    case State of
        0 ->
            if
                C == $& ->
                    entity_parser(Rest, [C], 1);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        1 ->
            if
                C == $# ->
                    entity_parser(Rest, [C | Acc], 2);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        2 ->
            if
                C == $a ->
                    entity_parser(Rest, [C | Acc], 3);
                C == $e ->
                    entity_parser(Rest, [C | Acc], 4);
                C == $i ->
                    entity_parser(Rest, [C | Acc], 5);
                C == $o ->
                    entity_parser(Rest, [C | Acc], 6);
                C == $u ->
                    entity_parser(Rest, [C | Acc], 7);
                C == $l ->
                    entity_parser(Rest, [C | Acc], 8);
                C == $r ->
                    entity_parser(Rest, [C | Acc], 9);
                C == $n ->
                    entity_parser(Rest, [C | Acc], 10);
                C == $t ->
                    entity_parser(Rest, [C | Acc], 11);
                C == $p ->
                    entity_parser(Rest, [C | Acc], 12);
                C == $s ->
                    entity_parser(Rest, [C | Acc], 13);
                C == $d ->
                    entity_parser(Rest, [C | Acc], 14);
                C == $g ->
                    entity_parser(Rest, [C | Acc], 15);
                C == $b ->
                    entity_parser(Rest, [C | Acc], 16);
                C == $c ->
                    entity_parser(Rest, [C | Acc], 17);
                C == $m ->
                    entity_parser(Rest, [C | Acc], 18);
                C == $v ->
                    entity_parser(Rest, [C | Acc], 19);
                C == $q ->
                    entity_parser(Rest, [C | Acc], 20);
                C == $h ->
                    entity_parser(Rest, [C | Acc], 21);
                C == $k ->
                    entity_parser(Rest, [C | Acc], 22);
                C == $x ->
                    entity_parser(Rest, [C | Acc], 23);
                C == $; ->
                    case lists:reverse([C | Acc]) of
                        "&#38;" -> entity_parser(Rest, [$& | Acc], 0);
                        "&#34;" -> entity_parser(Rest, [$\" | Acc], 0);
                        "&#39;" -> entity_parser(Rest, [$' | Acc], 0);
                        "&#60;" -> entity_parser(Rest, [$< | Acc], 0);
                        "&#62;" -> entity_parser(Rest, [$> | Acc], 0);
                        "&#92;" -> entity_parser(Rest, [$\\ | Acc], 0);
                        _ -> entity_parser(Rest, [C | Acc], 0)
                    end;
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        3 ->
            if
                C == $l ->
                    entity_parser(Rest, [C | Acc], 24);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        4 ->
            if
                C == $m ->
                    entity_parser(Rest, [C | Acc], 25);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        5 ->
            if
                C == $m ->
                    entity_parser(Rest, [C | Acc], 26);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        6 ->
            if
                C == $l ->
                    entity_parser(Rest, [C | Acc], 27);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        7 ->
            if
                C == $m ->
                    entity_parser(Rest, [C | Acc], 28);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        8 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 29);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        9 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 30);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        10 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 31);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        11 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 32);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        12 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 33);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        13 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 34);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        14 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 35);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        15 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 36);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        16 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 37);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        17 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 38);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        18 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 39);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        19 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 40);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        20 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 41);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        21 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 42);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        22 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 43);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        23 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 44);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        24 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 45);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        25 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 46);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        26 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 47);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        27 ->
            if
                C == $e ->
                    entity_parser(Rest, [C | Acc], 48);
                true ->
                    entity_parser(Rest, [C | Acc], 0)
            end;
        28 ->
            if
                C == $e ->
                    entity_parser(Rest,