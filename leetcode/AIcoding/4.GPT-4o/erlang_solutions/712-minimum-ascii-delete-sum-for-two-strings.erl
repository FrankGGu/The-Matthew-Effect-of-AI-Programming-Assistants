-module(solution).
-export([minimum_ascii_delete_sum/2]).

minimum_ascii_delete_sum(Str1, Str2) ->
    Length1 = string:length(Str1),
    Length2 = string:length(Str2),
    Matrix = lists:duplicate(Length1 + 1, lists:duplicate(Length2 + 1, 0)),
    Matrix1 = fill_matrix(Matrix, Str1, Str2, Length1, Length2),
    compute_result(Matrix1, Str1, Str2, Length1, Length2).

fill_matrix(Matrix, Str1, Str2, Length1, Length2) ->
    Matrix2 = lists:foldl(fun(_, Acc) ->
        lists:foldl(fun(_, InnerAcc) ->
            [0 | InnerAcc]
        end, [0], lists:seq(1, Length2)) ++ [0 | Acc]
    end, [], lists:seq(1, Length1)),
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, InnerAcc) ->
            if
                X =< Length1, Y =< Length2 ->
                    case string:at(Str1, X) =:= string:at(Str2, Y) of
                        true -> 
                            [lists:nth(X - 1, Acc) + 1 | InnerAcc];
                        false ->
                            Value1 = lists:nth(X - 1, Acc) + lists:nth(Y, Matrix2),
                            Value2 = lists:nth(X, Acc) + lists:nth(Y - 1, Matrix2),
                            MinValue = min(Value1, Value2),
                            [MinValue | InnerAcc]
                    end;
                true -> 
                    InnerAcc
            end
        end, [], lists:seq(1, Length2))
    end, Matrix2, lists:seq(1, Length1)).

compute_result(Matrix, Str1, Str2, Length1, Length2) ->
    TotalSum = lists:foldl(fun(Char, Acc) -> Acc + Char end, 0, string:to_list(Str1)) +
               lists:foldl(fun(Char, Acc) -> Acc + Char end, 0, string:to_list(Str2)),
    SumMatrix = lists:nth(Length1, lists:nth(Length2, Matrix)),
    TotalSum - SumMatrix.