-spec min_swaps(S :: unicode:unicode_binary()) -> integer().
min_swaps(S) ->
    Count1 = count_char(S, $1),
    Count0 = count_char(S, $0),
    if
        abs(Count1 - Count0) > 1 -> -1;
        true ->
            case Count1 > Count0 of
                true -> min_swaps_helper(S, $1);
                false when Count0 > Count1 -> min_swaps_helper(S, $0);
                true -> min(min_swaps_helper(S, $1), min_swaps_helper(S, $0))
            end
    end.

count_char(S, Char) ->
    lists:foldl(fun(C, Acc) -> if C =:= Char -> Acc + 1; true -> Acc end end, 0, S).

min_swaps_helper(S, StartChar) ->
    lists:foldl(fun({C, Idx}, Acc) ->
                    case (Idx rem 2 =:= 0) of
                        true when C =/= StartChar -> Acc + 1;
                        false when C =:= StartChar -> Acc + 1;
                        _ -> Acc
                    end
                end, 0, lists:zip(S, lists:seq(0, length(S) - 1))).

min(A, B) when A =< B -> A;
min(_, B) -> B.