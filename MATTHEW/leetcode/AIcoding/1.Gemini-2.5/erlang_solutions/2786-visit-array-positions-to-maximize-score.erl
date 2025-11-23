-module(solution).
-export([maximize_score/2]).

maximize_score(Nums, X) ->
    [H|_T] = Nums,
    FirstNumParity = H rem 2,

    {InitialEvenScore, InitialOddScore} =
        if FirstNumParity == 0 -> {H, H - X};
           true -> {H - X, H}
        end,

    {FinalEvenScore, FinalOddScore} =
        lists:foldl(fun(Num, {CurrentEvenScore, CurrentOddScore}) ->
                        NumParity = Num rem 2,
                        if NumParity == 0 -> % Current Num is even
                            NewEvenScore = max(CurrentEvenScore + Num, CurrentOddScore + Num - X),
                            {NewEvenScore, CurrentOddScore};
                           true -> % Current Num is odd
                            NewOddScore = max(CurrentOddScore + Num, CurrentEvenScore + Num - X),
                            {CurrentEvenScore, NewOddScore}
                        end
                    end, {InitialEvenScore, InitialOddScore}, tl(Nums)),

    max(FinalEvenScore, FinalOddScore).