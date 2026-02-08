-spec smallest_number(Num :: integer()) -> integer().
smallest_number(Num) ->
    case Num of
        0 -> 0;
        _ ->
            Digits = digits(abs(Num)),
            case Num > 0 of
                true -> 
                    Sorted = lists:sort(Digits),
                    case hd(Sorted) of
                        0 -> 
                            {NonZeros, Zeros} = lists:partition(fun(X) -> X =/= 0 end, Sorted),
                            [First | Rest] = NonZeros,
                            list_to_integer([First] ++ lists:duplicate(length(Zeros), 0) ++ Rest);
                        _ -> 
                            list_to_integer(Sorted)
                    end;
                false -> 
                    list_to_integer([$- | integer_to_list(-list_to_integer(lists:sort(fun(A, B) -> A > B end, Digits)))])
            end
    end.

digits(N) ->
    digits(N, []).

digits(0, Acc) -> Acc;
digits(N, Acc) ->
    digits(N div 10, [N rem 10 | Acc]).