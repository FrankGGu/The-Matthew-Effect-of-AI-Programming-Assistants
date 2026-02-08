-module(solution).
-export([break_palindrome/1]).

break_palindrome(P) ->
    case string:len(P) of
        1 -> "";
        _ ->
            PalindromeList = string:to_list(P),
            Result = break_palindrome_helper(PalindromeList),
            list_to_binary(Result)
    end.

break_palindrome_helper(P) ->
    case lists:foldl(fun(X, Acc) -> if X =:= $a, Acc =:= [] -> Acc; true -> [X | Acc] end end, [], P) of
        [] -> 
            [$_b | lists:tl(P)];
        _ -> 
            lists:map(fun(X) -> if X =:= $a -> $b; true -> X end end, P)
    end.