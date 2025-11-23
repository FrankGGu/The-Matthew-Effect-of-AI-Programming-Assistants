-module(solution).
-export([reorder_log_files/1]).

reorder_log_files/1 ->
    fun(L) ->
        {letters, digits} = lists:partition(fun({_, S}) -> is_letter(S) end, 
                                           lists:map(fun(X) -> {X, lists:nthtail(1, string:tokens(X, " "))} end, L)),
        LettersSorted = lists:sort(fun({A, [B]},{C, [D]}) -> 
                                       case B =< D of 
                                           true -> A < C; 
                                           false -> false 
                                       end 
                                   end, Letters),
        Letters = [A ++ " " ++ B || {A, [B]} <- LettersSorted],
        Digits = [X || X <- L, not lists:member(X, [A || {A, _} <- LettersSorted])],
        Letters ++ Digits
    end.

is_letter(Char) ->
    case Char of
        $0..$9 -> false;
        $a..$z -> true;
        $A..$Z -> true;
        _ -> false
    end.