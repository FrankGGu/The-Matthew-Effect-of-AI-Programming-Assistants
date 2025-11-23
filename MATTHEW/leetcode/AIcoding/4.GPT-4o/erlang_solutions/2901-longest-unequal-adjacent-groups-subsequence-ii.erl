-module(solution).
-export([longestUnequalAdjacency/1]).

longestUnequalAdjacency(List) ->
    Max = length(List),
    case Max of
        0 -> 0;
        _ -> longest_unequal_adjacent_groups(List, Max, 1, 1, hd(List))
    end.

longest_unequal_adjacent_groups([], _, MaxLen, CurrLen, _) -> MaxLen;
longest_unequal_adjacent_groups([H | T], MaxLen, CurrLen, PrevLen, Prev) ->
    NewCurrLen = if
        H =:= Prev -> 1;
        true -> CurrLen + 1
    end,
    NewMaxLen = max(MaxLen, NewCurrLen),
    longest_unequal_adjacent_groups(T, NewMaxLen, NewCurrLen, CurrLen, H).