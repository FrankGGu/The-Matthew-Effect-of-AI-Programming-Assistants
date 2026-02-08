-module(candy).
-export([can_eat/5]).

can_eat(CandyType, Day, StartFrom, EatLimit, TotalCandies) ->
    case CandyType of
        0 -> can_eat_helper(Day, StartFrom, EatLimit, TotalCandies, 0);
        1 -> can_eat_helper(Day, StartFrom, EatLimit, TotalCandies, 1);
        2 -> can_eat_helper(Day, StartFrom, EatLimit, TotalCandies, 2)
    end.

can_eat_helper(Day, StartFrom, EatLimit, TotalCandies, Type) ->
    Lower = StartFrom,
    Upper = StartFrom + EatLimit - 1,
    if
        Lower > TotalCandies -> false;
        Upper >= TotalCandies -> false;
        true ->
            case Type of
                0 -> Day >= Lower andalso Day =< Upper;
                1 -> (Day - 1) rem 3 == 0 andalso Day >= Lower andalso Day =< Upper;
                2 -> (Day - 1) rem 4 == 0 andalso Day >= Lower andalso Day =< Upper
            end
    end.