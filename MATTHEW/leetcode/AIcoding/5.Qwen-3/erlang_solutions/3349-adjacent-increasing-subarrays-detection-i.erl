-module(solution).
-export([is_possible/1]).

is_possible(A) ->
    N = length(A),
    case N of
        1 -> false;
        _ -> check(A, 1, 0)
    end.

check(_, _, 1) -> true;
check([], _, _) -> false;
check([H | T], I, C) ->
    if
        I == 1 -> check(T, I + 1, C + 1);
        true ->
            case T of
                [] -> false;
                [H2 | _] ->
                    if
                        H2 == H + 1 -> check(T, 1, 1);
                        true -> check(T, I + 1, C + 1)
                    end
            end
    end.