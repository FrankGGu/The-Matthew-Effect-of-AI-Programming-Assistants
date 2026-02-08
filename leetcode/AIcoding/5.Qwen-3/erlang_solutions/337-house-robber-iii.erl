-module(house_robber_iii).
-export([rob/1]).

-include_lib("stdlib/include/ms_transform.hrl").

rob(nil) -> 0;
rob({Val, Left, Right}) ->
    {Max, _} = rob_helper(Val, Left, Right),
    Max.

rob_helper(Val, Left, Right) ->
    {LeftMax, LeftMin} = case Left of
        nil -> {0, 0};
        _ -> rob_helper(Val, Left, nil)
    end,
    {RightMax, RightMin} -> case Right of
        nil -> {0, 0};
        _ -> rob_helper(Val, Right, nil)
    end,
    {Val + LeftMin + RightMin, max(LeftMax, RightMax)}.