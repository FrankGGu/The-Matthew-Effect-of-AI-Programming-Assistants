-module(maximal_square).
-export([maximal_square/1]).

maximal_square(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            DP = array:new({1, Rows}, {default, array:new({1, Cols}, {default, 0})}),
            Max = 0,
            FillDP(DP, Matrix, 0, 0, Rows, Cols, Max)
    end.

FillDP(DP, Matrix, I, J, Rows, Cols, Max) when I < Rows ->
    FillDP(DP, Matrix, I, J+1, Rows, Cols, Max);
FillDP(DP, Matrix, I, J, Rows, Cols, Max) when J < Cols ->
    Current = lists:nth(I+1, Matrix),
    Val = lists:nth(J+1, Current),
    case Val of
        $0 -> NewMax = Max, NewDP = DP;
        _ ->
            if
                I == 0; J == 0 ->
                    NewVal = 1,
                    NewDP = array:set({I+1, J+1}, NewVal, DP),
                    NewMax = max(Max, NewVal);
                true ->
                    Top = array:get({I, J+1}, DP),
                    Left = array:get({I+1, J}, DP),
                    Diag = array:get({I, J}, DP),
                    NewVal = min(min(Top, Left), Diag) + 1,
                    NewDP = array:set({I+1, J+1}, NewVal, DP),
                    NewMax = max(Max, NewVal)
            end
    end,
    FillDP(NewDP, Matrix, I+1, 0, Rows, Cols, NewMax);
FillDP(_, _, _, _, _, _, Max) -> Max.