-module(solution).
-export([are_digits_equal/1]).

are_digits_equal(S) ->
    Count = lists:foldl(fun(Char, Acc) ->
        case Char of
            $0 -> Acc#{{0} := 1 + maps:get(0, Acc, 0)};
            $1 -> Acc#{{1} := 1 + maps:get(1, Acc, 0)};
            $2 -> Acc#{{2} := 1 + maps:get(2, Acc, 0)};
            $3 -> Acc#{{3} := 1 + maps:get(3, Acc, 0)};
            $4 -> Acc#{{4} := 1 + maps:get(4, Acc, 0)};
            $5 -> Acc#{{5} := 1 + maps:get(5, Acc, 0)};
            $6 -> Acc#{{6} := 1 + maps:get(6, Acc, 0)};
            $7 -> Acc#{{7} := 1 + maps:get(7, Acc, 0)};
            $8 -> Acc#{{8} := 1 + maps:get(8, Acc, 0)};
            $9 -> Acc#{{9} := 1 + maps:get(9, Acc, 0)}
        end
    end, #{}, S),
    Values = maps:values(Count),
    lists:all(fun(V) -> V == hd(Values) end, Values).