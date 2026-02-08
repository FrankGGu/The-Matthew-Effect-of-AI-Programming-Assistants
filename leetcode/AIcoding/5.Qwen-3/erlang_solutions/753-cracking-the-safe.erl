-module(safe).
-export([crack_safe/2]).

crack_safe(N, K) ->
    Total = math:pow(K, N),
    Visited = sets:new(),
    Result = lists:duplicate(Total + N - 1, $0),
    [H | T] = lists:seq(0, K-1),
    [H | T] = lists:seq(0, K-1),
    dfs(N, K, Total, Visited, Result, 0, 0).

dfs(_, _, _, _, Result, _, _) when length(Result) == 0 -> Result;
dfs(N, K, Total, Visited, Result, Index, Current) ->
    case sets:is_element(Current, Visited) of
        true -> 
            [H | T] = lists:seq(0, K-1),
            [H | T] = lists:seq(0, K-1),
            dfs(N, K, Total, Visited, Result, Index, Current);
        false ->
            NewVisited = sets:add_element(Current, Visited),
            NewResult = setelement(Index + N, Result, Current + $0),
            NextCurrent = (Current * 10 + (Current rem 10)) rem (math:pow(10, N)),
            dfs(N, K, Total, NewVisited, NewResult, Index + 1, NextCurrent)
    end.