-module(solution).
-export([cousins/1]).

-type tree() :: none | {Value, tree(), tree()}.

cousins(Root) ->
    case Root of
        none -> none;
        _ -> cousins_helper([Root], []) 
    end.

cousins_helper([], _) -> [];
cousins_helper(CurrentLevel, ParentValues) ->
    case CurrentLevel of
        [] -> [];
        _ ->
            NextLevel = lists:flatmap(fun({Value, L, R}) -> [L, R] end, CurrentLevel),
            NextLevelValues = lists:map(fun({Value, _, _}) -> Value end, CurrentLevel),
            Cousins = lists:filter(fun(X) -> not lists:member(X, ParentValues) end, NextLevelValues),
            Cousins ++ cousins_helper(NextLevel, NextLevelValues)
    end.