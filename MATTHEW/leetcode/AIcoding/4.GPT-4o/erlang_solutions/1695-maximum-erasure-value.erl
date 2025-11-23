-module(solution).
-export([maximum_erasure_value/1]).

maximum_erasure_value(List) ->
    maximum_erasure_value(List, 0, 0, #{}, 0).

maximum_erasure_value([], MaxValue, _, _, _) -> 
    MaxValue;
maximum_erasure_value([H | T], MaxValue, CurrentSum, Seen, Start) ->
    case maps:is_key(H, Seen) of
        true ->
            NewStart = maps:get(H, Seen) + 1,
            NewSeen = maps:remove(H, Seen),
            maximum_erasure_value(T, max(MaxValue, CurrentSum), 0, NewSeen, NewStart);
        false ->
            NewSeen = maps:put(H, Start, Seen),
            maximum_erasure_value(T, MaxValue, CurrentSum + H, NewSeen, Start)
    end.