-module(paths_divisible_by_k).
-export([number_of_paths/3]).

number_of_paths(Grid, K, N) ->
    M = length(Grid),
    memo(M, N, K, Grid).

memo(M, N, K, Grid) ->
    Memo = array:new([{size, {M, N, K}}, {default, -1}]),
    memo(0, 0, 0, M, N, K, Grid, Memo).

memo(M, N, K, Grid, I, J, Rem, Memo) ->
    case array:get({I, J, Rem}, Memo) of
        -1 ->
            Value = element(I+1, element(J+1, Grid)),
            NewRem = (Rem + Value) rem K,
            case {I, J} of
                {M-1, N-1} ->
                    Result = case NewRem =:= 0 of
                        true -> 1;
                        false -> 0
                    end;
                _ ->
                    Down = case I < M-1 of
                        true -> memo(M, N, K, Grid, I+1, J, NewRem, Memo);
                        false -> 0
                    end,
                    Right = case J < N-1 of
                        true -> memo(M, N, K, Grid, I, J+1, NewRem, Memo);
                        false -> 0
                    end,
                    Result = (Down + Right) rem 1000000007
            end,
            array:set({I, J, Rem}, Result, Memo),
            Result;
        Val ->
            Val
    end.