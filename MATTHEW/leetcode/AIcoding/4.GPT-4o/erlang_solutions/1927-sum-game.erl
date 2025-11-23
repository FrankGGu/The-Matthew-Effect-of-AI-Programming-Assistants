-module(solution).
-export([sum_game/1]).

sum_game(Str) ->
    {A, B} = lists:foldl(fun(C, {A, B}) -> 
        case C of
            $0 -> {A + 0, B};
            $1 -> {A + 1, B};
            $2 -> {A + 2, B};
            $3 -> {A + 3, B};
            $4 -> {A + 4, B};
            $5 -> {A + 5, B};
            $6 -> {A + 6, B};
            $7 -> {A + 7, B};
            $8 -> {A + 8, B};
            $9 -> {A + 9, B};
            _ -> {A, B + 1}
        end
    end, {0, 0}, Str),
    A rem 9 =:= B rem 9.