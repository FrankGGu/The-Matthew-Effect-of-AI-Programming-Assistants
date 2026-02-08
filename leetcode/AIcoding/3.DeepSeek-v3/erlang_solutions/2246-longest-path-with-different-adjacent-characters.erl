-module(solution).
-export([longest_path/1]).

longest_path(Parent :: [integer()], S :: string()) -> integer().
longest_path(Parent, S) ->
    N = length(Parent),
    Children = lists:foldl(fun(_, Acc) -> Acc ++ [[]] end, [], lists:seq(1, N)),
    lists:foldl(fun(I, Acc) ->
        P = lists:nth(I + 1, Parent),
        if P >= 0 ->
            Ch = lists:nth(P + 1, Acc),
            lists:sublist(Acc, 1, P) ++ [Ch ++ [I]] ++ lists:sublist(Acc, P + 2, N - P - 1);
        true -> Acc
        end
    end, Children, lists:seq(0, N - 1)),
    {Max, _} = dfs(0, Children, S),
    Max.

dfs(Node, Children, S) ->
    Ch = lists:nth(Node + 1, Children),
    Max1 = 0,
    Max2 = 0,
    lists:foldl(fun(Child, {M1, M2}) ->
        {ChildMax, ChildPath} = dfs(Child, Children, S),
        if
            lists:nth(Node + 1, S) =/= lists:nth(Child + 1, S) ->
                if ChildPath > M1 ->
                    {ChildPath, M1};
                true ->
                    if ChildPath > M2 -> {M1, ChildPath};
                    true -> {M1, M2}
                    end
                end;
            true -> {M1, M2}
        end
    end, {Max1, Max2}, Ch),
    CurrentMax = max(Max1 + Max2 + 1, lists:foldl(fun(C, Acc) ->
        {CM, _} = dfs(C, Children, S),
        max(CM, Acc)
    end, 0, Ch)),
    {CurrentMax, Max1 + 1}.