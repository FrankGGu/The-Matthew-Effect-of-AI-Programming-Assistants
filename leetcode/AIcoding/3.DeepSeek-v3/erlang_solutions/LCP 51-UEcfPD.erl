-module(solution).
-export([cook/4]).

-spec cook(Materials :: [integer()], Cookbooks :: [[integer()]], Attribute :: [[integer()]], Limit :: [integer()]) -> integer().
cook(Materials, Cookbooks, Attribute, Limit) ->
    Max = -1,
    dfs(Materials, Cookbooks, Attribute, Limit, 0, 0, 0, 0, Max).

dfs(_, _, _, _, _, _, _, _, Max) when Max == 16#7FFFFFFF -> Max;
dfs(_, [], _, _, _, _, _, _, Max) -> Max;
dfs(Materials, [Cookbook | Rest], Attribute, Limit, A, B, C, D, Max) ->
    NewMax1 = case can_cook(Materials, Cookbook) of
        true ->
            [NewA, NewB, NewC, NewD] = lists:zipwith(fun(X, Y) -> X + Y end, [A, B, C, D], Attribute),
            case lists:all(fun({Val, Lim}) -> Val =< Lim end, lists:zip([NewA, NewB, NewC, NewD], Limit)) of
                true ->
                    NewSum = NewA + NewB + NewC + NewD,
                    if NewSum > Max -> NewSum; true -> Max end;
                false -> Max
            end;
        false -> Max
    end,
    NewMax2 = dfs(Materials, Rest, Attribute, Limit, A, B, C, D, NewMax1),
    case can_cook(Materials, Cookbook) of
        true ->
            NewMaterials = lists:zipwith(fun(X, Y) -> X - Y end, Materials, Cookbook),
            [NewA, NewB, NewC, NewD] = lists:zipwith(fun(X, Y) -> X + Y end, [A, B, C, D], Attribute),
            dfs(NewMaterials, Rest, Attribute, Limit, NewA, NewB, NewC, NewD, NewMax2);
        false -> NewMax2
    end.

can_cook(Materials, Cookbook) ->
    lists:all(fun({M, C}) -> M >= C end, lists:zip(Materials, Cookbook)).