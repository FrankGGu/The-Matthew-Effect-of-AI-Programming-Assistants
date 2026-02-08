-module(solution).
-export([min_subarray_len/2]).

min_subarray_len(N, P) ->
    Sum = lists:sum(N),
    Rem = Sum rem P,
    case Rem of
        0 -> 0;
        _ -> find_min_length(N, Rem, 0, 0, #{})
    end.

find_min_length([], _, Count, Min, _) -> 
    if Min == 0 -> -1; true -> Min end;
find_min_length([H | T], Rem, Count, Min, Map) ->
    NewCount = Count + H,
    NewMap = maps:put(NewCount rem P, Count, Map),
    case maps:find(Rem, NewMap) of
        {ok, MinCount} -> 
            NewMin = min(Min, Count - MinCount);
        _ -> 
            NewMin = Min
    end,
    find_min_length(T, Rem, NewCount, NewMin, NewMap).