-module(solution).
-export([minimal_exec_time/1]).

minimal_exec_time(Root) ->
    {Sum, Max} = dfs(Root),
    max(Sum / 2, Max).

dfs(null) -> {0, 0};
dfs({Val, Left, Right}) ->
    {SumL, MaxL} = dfs(Left),
    {SumR, MaxR} = dfs(Right),
    Sum = SumL + SumR + Val,
    Max = max(MaxL, MaxR),
    if
        MaxL > MaxR -> {Sum, max(MaxL, SumR + Val)};
        MaxR > MaxL -> {Sum, max(MaxR, SumL + Val)};
        true -> {Sum, max(Max, SumL + SumR + Val)}
    end.