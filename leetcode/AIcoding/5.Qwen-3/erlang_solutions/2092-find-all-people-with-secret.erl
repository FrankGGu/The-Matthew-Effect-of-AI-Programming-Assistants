-module(solution).
-export([findAllPeople/3]).

findAllPeople(Users, Meetings, X) ->
    Map = lists:foldl(fun({U, V, T}, Acc) ->
        Key = {min(U, V), max(U, V)},
        case maps:find(Key, Acc) of
            {ok, Ts} -> maps:put(Key, [T | Ts], Acc);
            _ -> maps:put(Key, [T], Acc)
        end
    end, maps:new(), Meetings),
    Sorted = lists:sort(fun({_, T1}, {_, T2}) -> T1 < T2 end, maps:to_list(Map)),
    Visited = sets:new(),
    Result = [],
    findSecret(Sorted, Users, X, Visited, Result).

findSecret([], _, _, _, Acc) ->
    Acc;
findSecret([{Key, Times} | Rest], Users, X, Visited, Acc) ->
    {U, V} = Key,
    SortedTimes = lists:sort(Times),
    {MeetingTime, _} = lists:nth(1, SortedTimes),
    if
        U == X orelse V == X ->
            NewVisited = sets:union(Visited, sets:from_list([U, V])),
            findSecret(Rest, Users, X, NewVisited, Acc ++ [U, V]);
        true ->
            NewVisited = sets:union(Visited, sets:from_list([U, V])),
            findSecret(Rest, Users, X, NewVisited, Acc)
    end.