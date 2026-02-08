-module(minimum_number_of_steps_to_make_two_strings_anagram).
-export([minSteps/2]).

minSteps(Sh, T) ->
    Count = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Sh),
    CountT = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), T),
    Diff = maps:fold(fun(K, V, Acc) -> 
        case maps:get(K, CountT, 0) of
            V -> Acc;
            _ -> Acc + abs(V - maps:get(K, CountT, 0))
        end
    end, 0, Count),
    Diff.