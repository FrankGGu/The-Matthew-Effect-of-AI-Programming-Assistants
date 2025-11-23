-module(solution).
-export([replace_digits/1]).

replace_digits(S) ->
    lists:map(fun(C) ->
        case C of
            $0 -> $0;
            $1 -> $2;
            $2 -> $3;
            $3 -> $4;
            $4 -> $5;
            $5 -> $6;
            $6 -> $7;
            $7 -> $8;
            $8 -> $9;
            $9 -> $10;
            _ -> C
        end
    end, list_to_string(S)).