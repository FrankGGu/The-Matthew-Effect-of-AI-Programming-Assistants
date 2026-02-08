-spec find_minimum_time(Tasks :: [[integer()]]) -> integer().
find_minimum_time(Tasks) ->
    SortedTasks = lists:sort(fun([_, E1, _], [_, E2, _]) -> E1 =< E2 end, Tasks),
    Slots = lists:foldl(fun([S, E, D], Acc) ->
        Used = lists:sum([1 || X <- Acc, X >= S, X =< E]),
        Needed = D - Used,
        if
            Needed > 0 ->
                ToAdd = lists:seq(E - Needed + 1, E),
                lists:umerge(Acc, ToAdd);
            true ->
                Acc
        end
    end, [], SortedTasks),
    length(Slots).