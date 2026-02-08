-module(maximum_swap).
-export([maximum_swap/1]).

maximum_swap(X) ->
    Digits = integer_to_list(X),
    MaxDigits = lists:foldl(fun(D, {M, I}) -> 
        NewM = max(M, D),
        NewI = if D > M -> I; true -> I + 1 end,
        {NewM, NewI}
    end, {hd(Digits), 0}, Digits),
    {MaxM, MaxI} = MaxDigits,
    case MaxI of
        0 -> X;
        _ -> 
            SwapDigit = lists:nth(MaxI + 1, Digits),
            NewDigits = lists:map(fun(D) -> if D == SwapDigit -> MaxM; true -> D end end, Digits),
            list_to_integer(NewDigits)
    end.