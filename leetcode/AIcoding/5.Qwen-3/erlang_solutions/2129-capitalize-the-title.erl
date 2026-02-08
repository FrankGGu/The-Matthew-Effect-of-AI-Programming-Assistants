-module(capitalize_title).
-export([capitalize_title/1]).

capitalize_title(S) ->
    lists:map(fun(Char) -> 
        case Char of
            $A -> $a;
            $B -> $b;
            $C -> $c;
            $D -> $d;
            $E -> $e;
            $F -> $f;
            $G -> $g;
            $H -> $h;
            $I -> $i;
            $J -> $j;
            $K -> $k;
            $L -> $l;
            $M -> $m;
            $N -> $n;
            $O -> $o;
            $P -> $p;
            $Q -> $q;
            $R -> $r;
            $S -> $s;
            $T -> $t;
            $U -> $u;
            $V -> $v;
            $W -> $w;
            $X -> $x;
            $Y -> $y;
            $Z -> $z;
            _ -> Char
        end
    end, S).