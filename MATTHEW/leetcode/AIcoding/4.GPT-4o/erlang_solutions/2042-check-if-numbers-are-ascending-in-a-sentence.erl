-module(solution).
-export([are_numbers_ascending/1]).

are_numbers_ascending(Sentence) ->
    Numbers = lists:filter(fun(X) -> is_integer(X) end, 
                lists:map(fun(S) -> list_to_integer(S) 
                end, string:tokens(Sentence, " "))),
    case Numbers of
        [] -> true;
        _ -> lists:foldl(fun(N, Acc) -> Acc andalso (N > hd(Acc)) end, [hd(Numbers)], tl(Numbers))
    end.