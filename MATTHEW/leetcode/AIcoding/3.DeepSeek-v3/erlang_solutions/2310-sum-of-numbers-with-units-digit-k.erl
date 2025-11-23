-spec minimum_numbers(Num :: integer(), K :: integer()) -> integer().
minimum_numbers(Num, K) ->
    case Num of
        0 -> 0;
        _ ->
            case K of
                0 ->
                    if
                        Num rem 10 == 0 -> min_positive(Num div 10, 1);
                        true -> -1
                    end;
                _ ->
                    if
                        Num < K -> -1;
                        true ->
                            case (Num - K) rem 10 of
                                0 -> min_positive((Num - K) div 10 + 1, 1);
                                _ ->
                                    case find_min(Num, K, 1) of
                                        -1 -> -1;
                                        Count -> Count
                                    end
                            end
                    end
            end
    end.

find_min(Num, K, Count) when Count =< 10 ->
    if
        Num < K * Count -> -1;
        true ->
            case (Num - K * Count) rem 10 of
                0 -> Count;
                _ -> find_min(Num, K, Count + 1)
            end
    end;
find_min(_, _, _) -> -1.

min_positive(A, B) when A >= 0 andalso B >= 0 ->
    if
        A =< B -> A;
        true -> B
    end;
min_positive(A, B) when A >= 0 -> A;
min_positive(_, B) -> B.