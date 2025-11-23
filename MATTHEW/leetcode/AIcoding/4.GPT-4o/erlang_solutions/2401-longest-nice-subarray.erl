-module(solution).
-export([longest_nice_subarray/1]).

longest_nice_subarray(List) ->
    longest_nice_subarray(List, 0, 0, 0, map:new()).

longest_nice_subarray([], _, MaxLength, _, _) ->
    MaxLength;
longest_nice_subarray([H | T], Start, MaxLength, LastIndex, Seen) ->
    NewSeen = map:put(H, true, Seen),
    case map:is_key(H, Seen) of
        true ->
            NewStart = lists:max([Start, map:get(H, Seen)]),
            NewMaxLength = lists:max([MaxLength, LastIndex - NewStart + 1]),
            longest_nice_subarray(T, NewStart + 1, NewMaxLength, LastIndex + 1, NewSeen);
        false ->
            longest_nice_subarray(T, Start, lists:max([MaxLength, LastIndex - Start + 1]), LastIndex + 1, NewSeen)
    end.