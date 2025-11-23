-module(solution).
-export([find_outlier/1]).

find_outlier([A, B, C | Rest]) ->
    IsA_Even = (A rem 2 == 0),
    IsB_Even = (B rem 2 == 0),
    IsC_Even = (C rem 2 == 0),

    EvenCount = (if IsA_Even -> 1; true -> 0 end) +
                (if IsB_Even -> 1; true -> 0 end) +
                (if IsC_Even -> 1; true -> 0 end),

    if EvenCount >= 2 ->
        if not IsA_Even -> A;
        not IsB_Even -> B;
        not IsC_Even -> C;
        true -> find_first_odd(Rest)
        end;
    true ->
        if IsA_Even -> A;
        IsB_Even -> B;
        IsC_Even -> C;
        true -> find_first_even(Rest)
        end
    end.

find_first_odd([H|_T]) ->
    if (H rem 2 /= 0) -> H;
    true -> find_first_odd(_T)
    end.

find_first_even([H|_T]) ->
    if (H rem 2 == 0) -> H;
    true -> find_first_even(_T)
    end.