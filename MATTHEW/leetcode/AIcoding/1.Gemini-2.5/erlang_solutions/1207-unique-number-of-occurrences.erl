-module(solution).
-export([uniqueOccurrences/1]).

uniqueOccurrences(Arr) ->
    % Step 1: Count occurrences of each number
    CountsMap = lists:foldl(fun(X, Acc) ->
                                maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                            end, #{}, Arr),

    % Step 2: Extract the list of occurrence counts
    CountsList = maps:values(CountsMap),

    % Step 3: Check if all occurrence counts are unique
    SetOfCounts = sets:from_list(CountsList),
    length(CountsList) == sets:size(SetOfCounts).