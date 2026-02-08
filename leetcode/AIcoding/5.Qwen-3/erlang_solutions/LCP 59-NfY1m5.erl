-module(bridge).
-export([solve/1]).

solve(Bridges) ->
    solve(Bridges, 0, 0, []).

solve([], _, _, Result) ->
    lists:reverse(Result);
solve([H | T], Index, Total, Result) ->
    {Left, Right} = H,
    case Left > Right of
        true ->
            solve(T, Index + 1, Total + Right, [Right | Result]);
        false ->
            solve(T, Index + 1, Total + Left, [Left | Result])
    end.