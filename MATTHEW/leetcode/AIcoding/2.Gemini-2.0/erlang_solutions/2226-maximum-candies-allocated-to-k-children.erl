-module(maximum_candies).
-export([maximum_candies/2]).

maximum_candies(Candies, K) ->
    maximum_candies(Candies, K, 0, lists:sum(Candies) div K).

maximum_candies(Candies, K, Low, High) when Low > High ->
    High;
maximum_candies(Candies, K, Low, High) ->
    Mid = Low + (High - Low + 1) div 2,
    case is_possible(Candies, K, Mid) of
        true ->
            maximum_candies(Candies, K, Mid, High);
        false ->
            maximum_candies(Candies, K, Low, Mid - 1)
    end.

is_possible(Candies, K, Value) ->
    case Value =:= 0 of
        true ->
            false;
        false ->
            Count = lists:sum([C div Value || C <- Candies]),
            Count >= K
    end.