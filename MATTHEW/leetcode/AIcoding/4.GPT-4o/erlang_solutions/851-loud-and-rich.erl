-module(loud_and_rich).
-export([loud_and_rich/2]).

loud_and_rich(Friends, Rich) ->
    N = length(Rich),
    Graph = lists:duplicate(N, []),
    lists:foreach(fun({X, Y}) -> Graph = lists:update_element(X + 1, Graph, [Y | lists:nth(X + 1, Graph)]) end, Friends),
    RichValues = lists:map(fun({Value}) -> Value end, Rich),
    RichMap = lists:zip(lists:seq(1, N), RichValues),
    lists:map(fun(X) -> dfs(X, Graph, RichMap, []) end, lists:seq(1, N)).

dfs(X, Graph, RichMap, Visited) ->
    case lists:member(X, Visited) of
        true -> [];
        false ->
            NewVisited = [X | Visited],
            Neighbors = lists:nth(X, Graph),
            RichValue = lists:keyfind(X, 1, RichMap),
            RichValueValue = case RichValue of 
                false -> 0; 
                {_, V} -> V 
            end,
            RichValueValue + lists:sum(lists:map(fun(Y) -> dfs(Y, Graph, RichMap, NewVisited) end, Neighbors))
    end.