-module(solution).
-export([are_digits_equal/1]).

are_digits_equal(S) ->
    Count = lists:foldl(fun(Char, Acc) ->
        case Char of
            $0 -> maps:update(0, Acc#{}(0) + 1, Acc);
            $1 -> maps:update(1, Acc#{}(1) + 1, Acc);
            $2 -> maps:update(2, Acc#{}(2) + 1, Acc);
            $3 -> maps:update(3, Acc#{}(3) + 1, Acc);
            $4 -> maps:update(4, Acc#{}(4) + 1, Acc);
            $5 -> maps:update(5, Acc#{}(5) + 1, Acc);
            $6 -> maps:update(6, Acc#{}(6) + 1, Acc);
            $7 -> maps:update(7, Acc#{}(7) + 1, Acc);
            $8 -> maps:update(8, Acc#{}(8) + 1, Acc);
            $9 -> maps:update(9, Acc#{}(9) + 1, Acc)
        end
    end, #{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0}, S),
    Values = maps:values(Count),
    lists:all(fun(V) -> V == hd(Values) end, Values).