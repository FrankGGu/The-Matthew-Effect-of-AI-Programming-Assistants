-module(solution).
-export([minAddToMakeValid/1]).

minAddToMakeValid(S) ->
    calculate_min_adds(string:to_list(S), 0, 0).

calculate_min_adds([], OpenCount, AddCount) ->
    OpenCount + AddCount;
calculate_min_adds([$(|T], OpenCount, AddCount) ->
    calculate_min_adds(T, OpenCount + 1, AddCount);
calculate_min_adds([$)|T], OpenCount, AddCount) ->
    case OpenCount > 0 of
        true -> calculate_min_adds(T, OpenCount - 1, AddCount);
        false -> calculate_min_adds(T, OpenCount, AddCount + 1)
    end.