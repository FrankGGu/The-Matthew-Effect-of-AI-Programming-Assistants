-module(solution).
-export([longest_non_decreasing/1]).

longest_non_decreasing(List) ->
    longest_non_decreasing(List, 1, 1).

longest_non_decreasing([], MaxLength, CurrentLength) ->
    Max = max(MaxLength, CurrentLength),
    Max;
longest_non_decreasing([_]) ->
    1;
longest_non_decreasing([H1, H2 | T]) ->
    case H2 >= H1 of
        true -> 
            longest_non_decreasing([H2 | T], 1, 2);
        false -> 
            Max = longest_non_decreasing([H2 | T], max(1, CurrentLength), 1),
            Max
    end.