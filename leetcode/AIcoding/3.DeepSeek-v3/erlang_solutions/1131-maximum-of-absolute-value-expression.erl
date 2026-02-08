-spec max_abs_val_expr(Arr1 :: [integer()], Arr2 :: [integer()]) -> integer().
max_abs_val_expr(Arr1, Arr2) ->
    N = length(Arr1),
    Max1 = -10000000, Max2 = -10000000, Max3 = -10000000, Max4 = -10000000,
    Min1 = 10000000, Min2 = 10000000, Min3 = 10000000, Min4 = 10000000,
    {FinalMax1, FinalMin1, FinalMax2, FinalMin2, FinalMax3, FinalMin3, FinalMax4, FinalMin4} = 
        lists:foldl(fun(I, {Mx1, Mn1, Mx2, Mn2, Mx3, Mn3, Mx4, Mn4}) ->
            X = lists:nth(I, Arr1),
            Y = lists:nth(I, Arr2),
            NewMx1 = max(Mx1, X + Y + I),
            NewMn1 = min(Mn1, X + Y + I),
            NewMx2 = max(Mx2, X + Y - I),
            NewMn2 = min(Mn2, X + Y - I),
            NewMx3 = max(Mx3, X - Y + I),
            NewMn3 = min(Mn3, X - Y + I),
            NewMx4 = max(Mx4, X - Y - I),
            NewMn4 = min(Mn4, X - Y - I),
            {NewMx1, NewMn1, NewMx2, NewMn2, NewMx3, NewMn3, NewMx4, NewMn4}
        end, {Max1, Min1, Max2, Min2, Max3, Min3, Max4, Min4}, lists:seq(1, N)),
    max(max(FinalMax1 - FinalMin1, FinalMax2 - FinalMin2), max(FinalMax3 - FinalMin3, FinalMax4 - FinalMin4)).