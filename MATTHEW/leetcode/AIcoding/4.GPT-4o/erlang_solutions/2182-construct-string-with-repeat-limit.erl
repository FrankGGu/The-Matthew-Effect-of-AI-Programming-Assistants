-module(solution).
-export([repeat_limit_string/2]).

repeat_limit_string(S, L) ->
    StringList = string:to_list(S),
    LimitList = lists:map(fun(X) -> {X, L} end, StringList),
    Result = construct_string(LimitList, []),
    lists:flatten(Result).

construct_string([], Acc) -> 
    Acc;
construct_string([{Char, 0} | T], Acc) -> 
    construct_string(T, Acc);
construct_string([{Char, N} | T], Acc) ->
    NewAcc = case Acc of
        [] -> [Char];
        [Last | _] when Last == Char -> 
            case T of
                [] -> Acc ++ [Char];
                [{NextChar, _} | _] -> 
                    [Char, NextChar] ++ Acc
            end;
        _ -> 
            [Char] ++ Acc
    end,
    construct_string([{Char, N - 1} | T], NewAcc).