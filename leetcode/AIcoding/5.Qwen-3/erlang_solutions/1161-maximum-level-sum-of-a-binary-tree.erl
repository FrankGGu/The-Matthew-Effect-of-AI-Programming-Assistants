-module(max_level_sum).
-export([maxLevelSum/1]).

-include_lib("eunit/include/eunit.hrl").

maxLevelSum(undefined) -> 0;
maxLevelSum({Val, Left, Right}) ->
    {MaxSum, _} = bfs([{Val, 1}], 0, 1),
    MaxSum.

bfs([], CurrentMax, _CurrentLevel) -> {CurrentMax, 0};
bfs([{Val, Level} | Rest], CurrentMax, CurrentLevel) ->
    if
        Level == CurrentLevel ->
            NewCurrentMax = max(CurrentMax, Val),
            bfs(Rest, NewCurrentMax, CurrentLevel);
        true ->
            {NewCurrentMax, NewLevel} = bfs(Rest, CurrentMax, Level),
            {NewCurrentMax, NewLevel}
    end;
bfs([{Val, Level}, {LeftVal, LeftLevel}, {RightVal, RightLevel} | Rest], CurrentMax, CurrentLevel) ->
    if
        Level == CurrentLevel ->
            NewCurrentMax = max(CurrentMax, Val),
            bfs([{LeftVal, Level + 1}, {RightVal, Level + 1} | Rest], NewCurrentMax, CurrentLevel);
        true ->
            {NewCurrentMax, NewLevel} = bfs([{LeftVal, Level + 1}, {RightVal, Level + 1} | Rest], CurrentMax, Level),
            {NewCurrentMax, NewLevel}
    end.