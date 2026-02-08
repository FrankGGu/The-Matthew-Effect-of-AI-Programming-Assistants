-module(max_candies).
-export([max_candies/2]).

max_candies(Candies, K) ->
    Low = 0,
    High = lists:max(Candies),
    find_max(Candies, K, Low, High).

find_max(_, _, Low, High) when Low >= High ->
    Low;
find_max(Candies, K, Low, High) ->
    Mid = (Low + High) div 2,
    case can_distribute(Candies, K, Mid) of
        true -> find_max(Candies, K, Mid + 1, High);
        false -> find_max(Candies, K, Low, Mid - 1)
    end.

can_distribute([], _, _) ->
    true;
can_distribute([C | Rest], K, Target) ->
    if
        C >= Target ->
            can_distribute(Rest, K - 1, Target);
        true ->
            can_distribute(Rest, K, Target)
    end.