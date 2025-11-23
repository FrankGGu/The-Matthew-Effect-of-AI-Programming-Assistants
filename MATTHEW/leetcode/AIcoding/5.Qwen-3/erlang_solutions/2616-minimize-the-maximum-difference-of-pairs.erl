-module(minimize_the_maximum_difference_of_pairs).
-export([minimize_max/2]).

minimize_max(Numbers, P) ->
    lists:sort(Numbers),
    minimize_max_helper(Numbers, P, 0, lists:sort(Numbers)).

minimize_max_helper(_, 0, Low, _) ->
    Low;
minimize_max_helper(Numbers, P, Low, High) ->
    Mid = (Low + High) div 2,
    if
        is_possible(Numbers, P, Mid) ->
            minimize_max_helper(Numbers, P, Low, Mid);
        true ->
            minimize_max_helper(Numbers, P, Mid + 1, High)
    end.

is_possible(_, 0, _) ->
    true;
is_possible([], _, _) ->
    false;
is_possible([A | Rest], P, Limit) ->
    case find_pair(A, Rest, Limit) of
        {ok, Index} ->
            is_possible(lists:nthtail(Index, Rest), P - 1, Limit);
        error ->
            false
    end.

find_pair(_, [], _) ->
    error;
find_pair(A, [B | Rest], Limit) ->
    if
        B - A =< Limit ->
            {ok, 0};
        true ->
            find_pair(A, Rest, Limit)
    end.