-module(solution).
-export([alternatingGroups/1]).

alternatingGroups(List) ->
    Groups = lists:foldl(fun(X, {Prev, Acc}) ->
        case Prev of
            none -> {X, [[X]]};
            _ when lists:member(X rem 2, [0, 1]) -> 
                {X, lists:append(Acc, [[X]]);
            _ -> 
                {X, lists:append(Acc, [[X]])}
        end
    end, {none, []}, List),
    lists:map(fun(Group) -> lists:reverse(Group) end, elem(Groups, 1)).