-module(solution).
-export([amount_of_time/2]).

-include_lib("eunit/include/eunit.hrl").

-type tree_node() :: {integer(), tree_node() | null, tree_node() | null}.

amount_of_time(null, _) -> 0;
amount_of_time(Root, Start) ->
    {_, Time} = dfs(Root, Start, null),
    Time.

dfs(null, _, _) -> {false, 0};
dfs({Val, Left, Right}, Start, Parent) ->
    {IsFound, Dist} = case Val of
        Start ->
            {true, 0};
        _ ->
            {false, 0}
    end,
    if
        IsFound ->
            {true, Dist + max(dfs(Left, Start, Val), dfs(Right, Start, Val))};
        true ->
            {LFound, LDist} = dfs(Left, Start, Val),
            {RFound, RDist} = dfs(Right, Start, Val),
            if
                LFound ->
                    {true, LDist + 1};
                RFound ->
                    {true, RDist + 1};
                true ->
                    {false, 0}
            end
    end.