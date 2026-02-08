-module(solution).
-export([largest_multiple_of_three/1]).

largest_multiple_of_three(Numbers) ->
    DigitCounts = lists:foldl(fun(N, Acc) -> 
        case lists:keyfind(N rem 3, 1, Acc) of
            false -> [{N rem 3, 1, [N]} | Acc];
            {_, Count, List} -> [{N rem 3, Count + 1, [N | List]} | lists:keydelete(N rem 3, 1, Acc)]
        end
    end, [], Numbers),
    TotalSum = lists:sum(Numbers),
    Remainder = TotalSum rem 3,
    ResultList = case Remainder of
        0 -> Numbers;
        1 -> remove_one_or_two(DigitCounts, 1, 2);
        2 -> remove_one_or_two(DigitCounts, 2, 1)
    end,
    ResultString = lists:sort(>)(ResultList),
    case ResultString of
        [] -> "0";
        _ -> lists:flatten(ResultString)
    end.

remove_one_or_two(DigitCounts, Remove1, Remove2) ->
    case lists:keyfind(Remove1, 1, DigitCounts) of
        {_, Count, List} when Count > 0 -> 
            List -- [hd(List)];
        _ -> 
            case lists:keyfind(Remove2, 1, DigitCounts) of
                {_, Count, List} when Count > 1 -> 
                    List -- [hd(List), hd(tl(List))];
                _ -> []
            end
    end.