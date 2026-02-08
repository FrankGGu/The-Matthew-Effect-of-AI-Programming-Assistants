-module(solution).
-export([numberOfSpecialCharacters/1]).

numberOfSpecialCharacters(S) ->
    Count = lists:foldl(fun(Char, Acc) -> 
        case lists:keymember(Char, 1, Acc) of
            true -> 
                [{Char, N} | _] = lists:keyfind(Char, 1, Acc),
                lists:keyreplace(Char, 1, Acc, {Char, N + 1});
            false -> 
                [{Char, 1} | Acc]
        end
    end, [], S),
    lists:foldl(fun({Char, N}, Acc) ->
        case lists:keymember(Char, 1, Acc) of
            true -> 
                [{Char, M} | _] = lists:keyfind(Char, 1, Acc),
                lists:keyreplace(Char, 1, Acc, {Char, M + N});
            false -> 
                [{Char, N} | Acc]
        end
    end, [], Count).