-module(solution).
-export([rob/1]).

rob(Root) ->
    {Included, Excluded} = dfs(Root),
    max(Included, Excluded).

dfs(null) ->
    {0, 0};
dfs({Val, Left, Right}) ->
    {L_inc, L_exc} = dfs(Left),
    {R_inc, R_exc} = dfs(Right),

    Current_Included = Val + L_exc + R_exc,
    Current_Excluded = max(L_inc, L_exc) + max(R_inc, R_exc),

    {Current_Included, Current_Excluded}.