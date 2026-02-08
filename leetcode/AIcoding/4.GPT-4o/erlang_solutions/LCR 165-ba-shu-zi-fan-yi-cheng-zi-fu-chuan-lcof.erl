-module(solution).
-export([decrypt/1]).

decrypt(S) ->
    lists:map(fun(Char) ->
        case Char of
            $0 -> $z;
            $1 -> $y;
            $2 -> $x;
            $3 -> $w;
            $4 -> $v;
            $5 -> $u;
            $6 -> $t;
            $7 -> $s;
            $8 -> $r;
            $9 -> $q;
            _ -> Char
        end
    end, string:to_list(S)).