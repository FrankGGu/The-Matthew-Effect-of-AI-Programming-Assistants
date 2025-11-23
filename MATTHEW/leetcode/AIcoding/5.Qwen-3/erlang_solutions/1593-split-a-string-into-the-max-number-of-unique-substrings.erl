-module(solution).
-export([max_unique_split/1]).

max_unique_split(S) ->
    max_unique_split(S, 0, dict:new(), 0).

max_unique_split(_, _, _, Max) when Max == length(S) ->
    Max;
max_unique_split(S, Start, Seen, Max) ->
    lists:foldl(fun End -> 
        Sub = string:substr(S, Start + 1, End - Start),
        case dict:is_key(Sub, Seen) of
            true -> Max;
            false ->
                NewSeen = dict:store(Sub, true, Seen),
                NewMax = max(Max, max_unique_split(S, End, NewSeen, Max + 1)),
                dict:erase(Sub, NewSeen),
                NewMax
        end
    end, Max, lists:seq(Start + 1, length(S))).

max_unique_split(_S) ->
    0.