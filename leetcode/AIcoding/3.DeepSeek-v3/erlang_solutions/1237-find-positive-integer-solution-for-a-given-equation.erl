-spec find_solution(Fun :: fun((integer(), integer()) -> integer()), Z :: integer()) -> [[integer()]].
find_solution(Fun, Z) ->
    find_solution(Fun, Z, 1, 1000, []).

find_solution(_Fun, _Z, X, Y, Acc) when X > 1000; Y < 1 ->
    Acc;
find_solution(Fun, Z, X, Y, Acc) ->
    case Fun(X, Y) of
        Z -> find_solution(Fun, Z, X + 1, Y - 1, [[X, Y] | Acc]);
        Res when Res < Z -> find_solution(Fun, Z, X + 1, Y, Acc);
        Res when Res > Z -> find_solution(Fun, Z, X, Y - 1, Acc)
    end.