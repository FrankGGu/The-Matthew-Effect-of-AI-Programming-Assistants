-module(solution).
-export([largestMerge/2]).

largestMerge(S1, S2) ->
    largest_merge(S1, S2, []).

largest_merge([], []) -> 
    [];
largest_merge([], S2) -> 
    S2;
largest_merge(S1, []) -> 
    S1;
largest_merge(S1, S2) ->
    case S1 >= S2 of
        true -> 
            [hd(S1) | largest_merge(tl(S1), S2)];
        false -> 
            [hd(S2) | largest_merge(S1, tl(S2))]
    end.