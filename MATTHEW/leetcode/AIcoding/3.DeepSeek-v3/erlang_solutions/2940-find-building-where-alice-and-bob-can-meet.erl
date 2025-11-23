-spec can_meet(Buildings :: [integer()], Queries :: [[integer()]]) -> [integer()].
can_meet(Buildings, Queries) ->
    lists:map(fun([I, J]) -> 
        if 
            I =:= J -> I;
            true ->
                Start = min(I, J) + 1,
                End = max(I, J),
                Max = lists:max(lists:sublist(Buildings, Start, End - Start + 1)),
                if 
                    Max < max(lists:nth(I + 1, Buildings), lists:nth(J + 1, Buildings)) -> max(I, J);
                    true -> -1
                end
        end
    end, Queries).