-module(solution).
-export([crack_password/1]).

crack_password(Password) ->
    Sorted = lists:sort(fun(A, B) -> 
        case A ++ B < B ++ A of
            true -> true;
            false -> false
        end
    end, Password),
    case lists:all(fun(X) -> X == "0" end, Sorted) of
        true -> "0";
        false -> lists:concat(Sorted)
    end.