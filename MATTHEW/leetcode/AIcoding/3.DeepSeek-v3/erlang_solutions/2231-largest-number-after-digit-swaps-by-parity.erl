-spec largest_integer(Num :: integer()) -> integer().
largest_integer(Num) ->
    Digits = integer_to_list(Num),
    Even = lists:filter(fun(D) -> (D - $0) rem 2 == 0 end, Digits),
    Odd = lists:filter(fun(D) -> (D - $0) rem 2 =/= 0 end, Digits),
    SortedEven = lists:sort(fun(A, B) -> A >= B end, Even),
    SortedOdd = lists:sort(fun(A, B) -> A >= B end, Odd),
    Reconstructed = lists:map(fun(D) ->
        case (D - $0) rem 2 of
            0 -> hd(SortedEven),
                 SortedEven = tl(SortedEven);
            _ -> hd(SortedOdd),
                 SortedOdd = tl(SortedOdd)
        end
    end, Digits),
    list_to_integer(Reconstructed).