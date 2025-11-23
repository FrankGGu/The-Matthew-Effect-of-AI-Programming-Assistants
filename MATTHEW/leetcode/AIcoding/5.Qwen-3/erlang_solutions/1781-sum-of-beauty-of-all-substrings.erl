-module(solve).
-export([beauty_sum/1]).

beauty_sum(S) ->
    N = erlang:length(S),
    Total = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Sub = string:substr(S, I+1, J-I),
            Min = lists:foldl(fun(C, MinSoFar) ->
                case C of
                    $a -> min(MinSoFar, 1);
                    $b -> min(MinSoFar, 2);
                    $c -> min(MinSoFar, 3);
                    $d -> min(MinSoFar, 4);
                    $e -> min(MinSoFar, 5);
                    $f -> min(MinSoFar, 6);
                    $g -> min(MinSoFar, 7);
                    $h -> min(MinSoFar, 8);
                    $i -> min(MinSoFar, 9);
                    $j -> min(MinSoFar, 10);
                    $k -> min(MinSoFar, 11);
                    $l -> min(MinSoFar, 12);
                    $m -> min(MinSoFar, 13);
                    $n -> min(MinSoFar, 14);
                    $o -> min(MinSoFar, 15);
                    $p -> min(MinSoFar, 16);
                    $q -> min(MinSoFar, 17);
                    $r -> min(MinSoFar, 18);
                    $s -> min(MinSoFar, 19);
                    $t -> min(MinSoFar, 20);
                    $u -> min(MinSoFar, 21);
                    $v -> min(MinSoFar, 22);
                    $w -> min(MinSoFar, 23);
                    $x -> min(MinSoFar, 24);
                    $y -> min(MinSoFar, 25);
                    $z -> min(MinSoFar, 26)
                end
            end, 26, Sub),
            Max = lists:foldl(fun(C, MaxSoFar) ->
                case C of
                    $a -> max(MaxSoFar, 1);
                    $b -> max(MaxSoFar, 2);
                    $c -> max(MaxSoFar, 3);
                    $d -> max(MaxSoFar, 4);
                    $e -> max(MaxSoFar, 5);
                    $f -> max(MaxSoFar, 6);
                    $g -> max(MaxSoFar, 7);
                    $h -> max(MaxSoFar, 8);
                    $i -> max(MaxSoFar, 9);
                    $j -> max(MaxSoFar, 10);
                    $k -> max(MaxSoFar, 11);
                    $l -> max(MaxSoFar, 12);
                    $m -> max(MaxSoFar, 13);
                    $n -> max(MaxSoFar, 14);
                    $o -> max(MaxSoFar, 15);
                    $p -> max(MaxSoFar, 16);
                    $q -> max(MaxSoFar, 17);
                    $r -> max(MaxSoSoFar, 18);
                    $s -> max(MaxSoFar, 19);
                    $t -> max(MaxSoFar, 20);
                    $u -> max(MaxSoFar, 21);
                    $v -> max(MaxSoFar, 22);
                    $w -> max(MaxSoFar, 23);
                    $x -> max(MaxSoFar, 24);
                    $y -> max(MaxSoFar, 25);
                    $z -> max(MaxSoFar, 26)
                end
            end, 0, Sub),
            Acc2 + (Max - Min)
        end, Acc, lists:seq(I+1, N))
    end, Total, lists:seq(0, N-1)).