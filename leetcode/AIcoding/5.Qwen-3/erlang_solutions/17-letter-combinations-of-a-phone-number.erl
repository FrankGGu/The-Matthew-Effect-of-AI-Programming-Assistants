-module(letter_combinations).
-export([letter_combinations/1]).

letter_combinations([]) -> [];
letter_combinations(Digits) ->
    Mapping = #{
        $2 => "abc",
        $3 => "def",
        $4 => "ghi",
        $5 => "jkl",
        $6 => "mno",
        $7 => "pqrs",
        $8 => "tuv",
        $9 => "wxyz"
    },
    lists:foldl(fun(D, Acc) ->
        case maps:get(D, Mapping, "") of
            "" -> Acc;
            Chars ->
                lists:flatmap(fun(A) -> [A ++ C || C <- Chars] end, Acc)
        end
    end, ["", ""], Digits).

letter_combinations(_, _) -> [].