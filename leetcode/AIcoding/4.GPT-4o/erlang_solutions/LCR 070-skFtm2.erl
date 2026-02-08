-module(solution).
-export([single_non_duplicate/1]).

single_non_duplicate(List) ->
    single_non_duplicate(List, 0, length(List) - 1).

single_non_duplicate(List, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    IfEven = (Mid rem 2) == 0,
    IfMatched = (lists:nth(Mid + 1, List) == lists:nth(Mid, List)),

    case {IfEven, IfMatched} of
        {true, true} -> single_non_duplicate(List, Mid + 1, High);
        {true, false} -> single_non_duplicate(List, Low, Mid);
        {false, true} -> single_non_duplicate(List, Low, Mid - 1);
        {false, false} -> single_non_duplicate(List, Mid + 1, High)
    end;
single_non_duplicate(List, Low, High) ->
    lists:nth(Low + 1, List).