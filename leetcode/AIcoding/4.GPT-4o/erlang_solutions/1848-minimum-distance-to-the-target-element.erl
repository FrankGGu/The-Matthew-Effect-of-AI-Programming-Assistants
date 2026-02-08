-module(solution).
-export([get_min_distance/3]).

get_min_distance(List, Target, Start) ->
    get_min_distance(List, Target, Start, 0).

get_min_distance([], _, _, _) -> 
    -1;
get_min_distance([H | T], Target, Start, Index) ->
    case H of
        Target -> 
            if 
                Index >= Start -> 
                    Index - Start;
                true -> 
                    get_min_distance(T, Target, Start, Index + 1)
            end;
        _ -> 
            get_min_distance(T, Target, Start, Index + 1)
    end.