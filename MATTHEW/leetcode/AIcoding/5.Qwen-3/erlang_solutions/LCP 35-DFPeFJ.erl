-module(leetcode).
-export([can_reach/2]).

can_reach(Stations, Limit) ->
    can_reach(Stations, Limit, 0, 0).

can_reach([], _, _, _) ->
    true;
can_reach([H | T], Limit, Battery, Index) ->
    case Battery >= Index of
        true ->
            NewBattery = min(Battery + H, Limit),
            can_reach(T, Limit, NewBattery, Index + 1);
        false ->
            false
    end.