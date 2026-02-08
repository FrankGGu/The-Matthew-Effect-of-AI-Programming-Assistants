-module(solution).
-export([check_string/1]).

check_string(S) ->
    case lists:all(fun(C) -> C =:= $a orelse C =:= $b end, S) of
        true -> check_order(S);
        false -> false
    end.

check_order([]) -> true;
check_order([H | T]) ->
    case H of
        $a -> check_order(T);
        $b -> lists:all(fun(C) -> C =:= $b end, T);
        _ -> false
    end.