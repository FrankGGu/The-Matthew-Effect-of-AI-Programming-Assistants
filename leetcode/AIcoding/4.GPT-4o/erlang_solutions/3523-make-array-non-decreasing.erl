-module(solution).
-export([check_possibility/1]).

check_possibility(Array) ->
    check_possibility(Array, 0, false).

check_possibility([], _, _) -> true;
check_possibility([H | T], Prev, Changed) ->
    case T of
        [] -> true;
        [Next | _] ->
            if
                H > Next ->
                    if
                        Changed -> false;
                        true -> 
                            check_possibility([H | T -- [Next]], H, true)
                    end;
                true -> 
                    check_possibility(T, H, Changed)
            end
    end.