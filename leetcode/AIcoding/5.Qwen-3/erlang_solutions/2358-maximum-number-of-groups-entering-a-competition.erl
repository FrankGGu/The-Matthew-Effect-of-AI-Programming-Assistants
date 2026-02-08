-module(max_groups).
-export([maxNumberOfGroups/1]).

maxNumberOfGroups(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update(N, Acc#{N => Acc:N + 1}, Acc) end, #{}, Nums),
    Sorted = lists:sort(maps:values(Count)),
    Groups = 0,
    max_groups(Sorted, Groups).

max_groups([], Groups) ->
    Groups;
max_groups([H | T], Groups) ->
    if
        H > 1 ->
            NewGroups = Groups + 1,
            max_groups(T, NewGroups);
        true ->
            max_groups(T, Groups)
    end.