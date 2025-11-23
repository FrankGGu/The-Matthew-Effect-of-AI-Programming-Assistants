-module(solution).
-export([shift_distance/2]).

shift_distance(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    if
        Len1 =/= Len2 ->
            -1;
        Len1 =:= 0 ->
            0;
        true ->
            S1S1 = S1 ++ S1,
            Index = string:str(S1S1, S2),
            if
                Index =:= 0 ->
                    -1;
                true ->
                    Index - 1
            end
    end.