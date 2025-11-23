-module(solution).
-export([largest_number_after_swap/1]).

largest_number_after_swap(N) ->
    Digits = integer_to_list(N),
    {Even, Odd} = lists:foldl(fun(D, {Even, Odd}) ->
        case (D rem 2) of
            0 -> {D, Odd ++ [D]};
            _ -> {Even ++ [D], Odd}
        end
    end, {[], []}, Digits),
    EvenSorted = lists:sort(Even, fun(A, B) -> A > B end),
    OddSorted = lists:sort(Odd, fun(A, B) -> A > B end),
    Result = lists:map(fun(D) ->
        case (D rem 2) of
            0 -> lists:nth(1, EvenSorted), EvenSorted = tl(EvenSorted);
            _ -> lists:nth(1, OddSorted), OddSorted = tl(OddSorted)
        end
    end, Digits),
    list_to_integer(Result).