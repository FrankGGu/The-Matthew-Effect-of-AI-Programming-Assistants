-module(solution).
-export([mirror_score/1]).

mirror_score(S) ->
    Mirror = #{
        $A => $A, $B => $dummy, $C => $dummy, $D => $dummy, $E => $3, $F => $dummy, $G => $dummy,
        $H => $H, $I => $I, $J => $dummy, $K => $dummy, $L => $dummy, $M => $M, $N => $dummy,
        $O => $O, $P => $dummy, $Q => $dummy, $R => $dummy, $S => $2, $T => $T, $U => $U,
        $V => $V, $W => $W, $X => $X, $Y => $Y, $Z => $5,
        $a => $dummy, $b => $dummy, $c => $dummy, $d => $dummy, $e => $dummy, $f => $dummy, $g => $dummy,
        $h => $dummy, $i => $i, $j => $dummy, $k => $dummy, $l => $l, $m => $dummy, $n => $dummy,
        $o => $o, $p => $q, $q => $p, $r => $dummy, $s => $dummy, $t => $dummy, $u => $u,
        $v => $v, $w => $w, $x => $x, $y => $dummy, $z => $dummy,
        $0 => $0, $1 => $1, $2 => $S, $3 => $E, $5 => $Z, $8 => $8
    },
    lists:sum(lists:map(fun(C) ->
        case maps:get(C, Mirror, undefined) of
            C -> 1;
            _ -> 0
        end
    end, S)).