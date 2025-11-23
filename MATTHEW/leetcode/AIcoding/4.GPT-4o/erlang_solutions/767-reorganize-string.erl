-module(solution).
-export([reorganize_string/1]).

reorganize_string(S) ->
    Counts = lists:foldl(fun(Char, Acc) -> 
        Map = maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, string:to_list(S)),
    MaxCount = maps:fold(fun(_, Count, Acc) -> max(Count, Acc) end, 0, Counts),
    Total = length(S),
    if 
        MaxCount > (Total + 1) div 2 -> 
            ""
        ; 
            true -> 
            Reorganized = reorganize(Counts, [], Total),
            lists:flatten(Reorganized)
    end.

reorganize(Counts, Acc, 0) -> 
    Acc;
reorganize(Counts, Acc, Remaining) -> 
    {Char, Count} = maps:fold(fun(K, V, {BestChar, BestCount}) -> 
        if 
            V > BestCount -> 
                {K, V} 
            ; 
                {BestChar, BestCount} 
        end 
    end, {undefined, 0}, Counts),
    case Count of 
        0 -> 
            Acc;
        _ -> 
            NewCounts = maps:update(Char, Count - 1, Counts),
            reorganize(NewCounts, [Char | Acc], Remaining - 1)
    end.