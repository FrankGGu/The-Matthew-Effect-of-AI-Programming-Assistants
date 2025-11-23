-module(pseudo_palindrome_paths).
-export([pseudo_palindromic_paths/1]).

pseudo_palindromic_paths(Root) ->
    pseudo_palindromic_paths(Root, []).

pseudo_palindromic_paths(null, Acc) ->
    case lists:foldl(fun(X, Count) -> if X rem 2 == 1 then Count + 1 else Count end, 0, Acc) of
        0 -> 1;
        1 -> 1;
        _ -> 0
    end;
pseudo_palindromic_paths({val, Val, Left, Right}, Acc) ->
    pseudo_palindromic_paths(Left, update_acc(Val, Acc)) + pseudo_palindromic_paths(Right, update_acc(Val, Acc)).

update_acc(Val, Acc) ->
    case lists:member(Val, Acc) of
        true -> lists:delete(Val, Acc);
        false -> [Val|Acc]
    end.