-module(solution).
-export([max_non_overlapping/2]).

max_non_overlapping(Array, Target) ->
    max_non_overlapping(Array, Target, 0, #{}, 0).

max_non_overlapping([], _, Count, _, Count) -> 
    Count;

max_non_overlapping([H | T], Target, Sum, Seen, Count) ->
    NewSum = Sum + H,
    NewCount = case maps:find(NewSum - Target, Seen) of
        {ok, _} -> Count + 1;
        _ -> Count
    end,
    NewSeen = maps:update_with(NewSum, fun(X) -> X + 1 end, 1, Seen),
    max_non_overlapping(T, Target, NewSum, NewSeen, NewCount).