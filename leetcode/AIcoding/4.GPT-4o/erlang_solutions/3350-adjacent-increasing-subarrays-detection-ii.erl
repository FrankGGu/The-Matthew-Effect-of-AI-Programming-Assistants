-module(solution).
-export([adjacent_increasing_subarrays/1]).

adjacent_increasing_subarrays(List) ->
    Length = length(List),
    case Length < 2 of
        true -> false;
        false -> check_adjacent(List, 0)
    end.

check_adjacent(List, Index) ->
    case Index >= length(List) - 1 of
        true -> false;
        false ->
            case lists:nth(Index + 1, List) > lists:nth(Index, List) of
                true -> true;
                false -> check_adjacent(List, Index + 1)
            end
    end.