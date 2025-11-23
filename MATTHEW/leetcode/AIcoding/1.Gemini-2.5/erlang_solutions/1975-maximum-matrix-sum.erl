-module(solution).
-export([max_matrix_sum/1]).

max_matrix_sum(Matrix) ->
    % Get the absolute value of the first element to initialize MinAbsVal.
    % The problem constraints guarantee a non-empty matrix.
    FirstElementAbs = abs(hd(hd(Matrix))),

    % Fold over the matrix to calculate TotalAbsSum, NegCount, and MinAbsVal.
    {TotalAbsSum, NegCount, MinAbsVal} =
        lists:foldl(fun(Row, {AccSum, AccNegCount, AccMinAbsVal}) ->
                        lists:foldl(fun(X, {InnerAccSum, InnerAccNegCount, InnerAccMinAbsVal}) ->
                                        AbsX = abs(X),
                                        NewSum = InnerAccSum + AbsX,
                                        NewNegCount = if X < 0 -> InnerAccNegCount + 1; true -> InnerAccNegCount end,
                                        NewMinAbsVal = min(InnerAccMinAbsVal, AbsX),
                                        {NewSum, NewNegCount, NewMinAbsVal}
                                    end,
                                    {AccSum, AccNegCount, AccMinAbsVal},
                                    Row)
                    end,
                    {0, 0, FirstElementAbs}, % Initial state: Sum=0, NegCount=0, MinAbsVal=abs(first element)
                    Matrix),

    % Determine the final sum based on the parity of negative numbers.
    % If NegCount is even, all elements can be made positive.
    % If NegCount is odd, one element with the smallest absolute value must remain negative.
    if NegCount rem 2 == 0 ->
        TotalAbsSum;
    true ->
        TotalAbsSum - 2 * MinAbsVal
    end.