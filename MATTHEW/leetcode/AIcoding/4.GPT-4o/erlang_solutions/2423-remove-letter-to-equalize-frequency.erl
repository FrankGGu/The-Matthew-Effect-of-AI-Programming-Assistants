-module(solution).
-export([equal_frequency/1]).

equal_frequency(S) ->
    Frequencies = lists:foldl(fun(C, Acc) -> 
        maps:update_with(C, fun(X) -> X + 1 end, fun() -> 1 end, Acc) 
    end, #{}, string:to_list(S)),
    Counts = maps:values(Frequencies),
    UniqueCounts = lists:usort(Counts),
    case length(UniqueCounts) of
        1 -> true;
        2 -> 
            (hd(UniqueCounts) - 1 =:= hd(tl(UniqueCounts))) orelse
            (hd(tl(UniqueCounts)) =:= 1);
        _ -> false
    end.