-module(solution).
-export([number_of_unique_good_subsequences/1]).

number_of_unique_good_subsequences(Binary) ->
    DP0 = 0,
    DP1 = 0,
    Has0 = 0,
    Has1 = 0,
    lists:foldl(fun
        ($0, {D0, D1, H0, H1}) ->
            NewD0 = (D0 + D1 + 1) rem 1000000007,
            NewH0 = 1,
            {NewD0, D1, NewH0, H1};
        ($1, {D0, D1, H0, H1}) ->
            NewD1 = (D0 + D1 + 1) rem 1000000007,
            NewH1 = 1,
            {D0, NewD1, H0, NewH1}
    end, {DP0, DP1, Has0, Has1}, Binary),
    {D0, D1, H0, H1} = lists:foldl(fun
        ($0, {Acc0, Acc1, AccH0, AccH1}) ->
            NewAcc0 = (Acc0 + Acc1 + 1) rem 1000000007,
            NewAccH0 = 1,
            {NewAcc0, Acc1, NewAccH0, AccH1};
        ($1, {Acc0, Acc1, AccH0, AccH1}) ->
            NewAcc1 = (Acc0 + Acc1 + 1) rem 1000000007,
            NewAccH1 = 1,
            {Acc0, NewAcc1, AccH0, NewAccH1}
    end, {DP0, DP1, Has0, Has1}, Binary),
    (D0 + D1 + H0) rem 1000000007.