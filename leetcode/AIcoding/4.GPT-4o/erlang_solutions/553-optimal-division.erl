-module(solution).
-export([optimalDivision/1]).

optimalDivision(Numbers) ->
    case Numbers of
        [] -> "";
        [X] -> integer_to_list(X);
        [X, Y] -> integer_to_list(X) ++ "/" ++ integer_to_list(Y);
        _ -> 
            Head = hd(Numbers),
            Tail = tl(Numbers),
            ListTail = lists:map(fun(X) -> integer_to_list(X) end, Tail),
            "/" ++ string:join(ListTail, "/") ++ "/" ++ integer_to_list(Head)
    end.