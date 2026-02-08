-module(solution).
-export([is_valid/1]).

is_valid(S) ->
    check_valid(S, []).

check_valid([], []) -> true;
check_valid([], _) -> false;
check_valid([H | T], Stack) ->
    case H of
        $c -> check_valid(T, [$c | Stack]);
        $a -> case Stack of
                    [$c, $a] -> check_valid(T, tl(Stack));
                    _ -> check_valid(T, [$a | Stack])
                end;
        $b -> case Stack of
                    [$a, $b] -> check_valid(T, tl(Stack));
                    _ -> check_valid(T, [$b | Stack])
                end;
        _ -> false
    end.