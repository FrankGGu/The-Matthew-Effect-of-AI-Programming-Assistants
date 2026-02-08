-module(solution).
-export([minimizeResult/1]).

minimizeResult(Expression) ->
    Len = length(Expression),
    PlusIdx = string:str(Expression, "+"), % 1-based index of '+'

    % I is the 1-based start index of num1_suffix
    % J is the 1-based end index of num2_prefix
    % Initial call for the recursive loop
    minimizeResult_loop(1, PlusIdx - 1, PlusIdx + 1, Len, Expression, PlusIdx, infinity, "").

minimizeResult_loop(I, MaxI, J, MaxJ, Expression, PlusIdx, CurrentMinVal, CurrentMinExpr) when I =< MaxI ->
    case J =< MaxJ of
        true ->
            % Extract substrings using 1-based indexing for lists:sublist(List, Start, Length)
            Num1PrefixStr = lists:sublist(Expression, 1, I - 1),
            Num1SuffixStr = lists:sublist(Expression, I, PlusIdx - I),
            Num2PrefixStr = lists:sublist(Expression, PlusIdx + 1, J - PlusIdx),
            Num2SuffixStr = lists:sublist(Expression, J + 1, MaxJ - J),

            % Convert to integers, handling empty strings for prefix/suffix (treated as 1)
            Num1PrefixVal = case Num1PrefixStr of [] -> 1; _ -> string:to_integer(Num1PrefixStr) end,
            Num1SuffixVal = string:to_integer(Num1SuffixStr),
            Num2PrefixVal = string:to_integer(Num2PrefixStr),
            Num2SuffixVal = case Num2SuffixStr of [] -> 1; _ -> string:to_integer(Num2SuffixStr) end,

            % Calculate current value
            Val = Num1PrefixVal * (Num1SuffixVal + Num2PrefixVal) * Num2SuffixVal,

            % Construct current expression string
            Expr = Num1PrefixStr ++ "(" ++ Num1SuffixStr ++ "+" ++ Num2PrefixStr ++ ")" ++ Num2SuffixStr,

            % Update min_val and min_expr if current value is smaller
            {NewMinVal, NewMinExpr} =
                if Val < CurrentMinVal -> {Val, Expr};
                   true -> {CurrentMinVal, CurrentMinExpr}
                end,

            % Recurse for the next J (inner loop)
            minimizeResult_loop(I, MaxI, J + 1, MaxJ, Expression, PlusIdx, NewMinVal, NewMinExpr);
        false ->
            % J loop finished for current I, move to next I (outer loop)
            % Reset J to its starting value for the new I
            minimizeResult_loop(I + 1, MaxI, PlusIdx + 1, MaxJ, Expression, PlusIdx, CurrentMinVal, CurrentMinExpr)
    end;
minimizeResult_loop(_I, _MaxI, _J, _MaxJ, _Expression, _PlusIdx, _MinVal, MinExpr) ->
    % Base case: All loops finished, return the final minimum expression
    MinExpr.