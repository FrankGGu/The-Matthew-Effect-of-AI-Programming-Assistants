-module(solution).
-export([trap/1]).

trap(Height) ->
    trap(Height, 0, 0, 0).

trap([], _, _, Result) ->
    Result;
trap([H | T], LeftMax, RightMax, Result) ->
    NewLeftMax = max(LeftMax, H),
    RightMax = case T of
                   [] -> RightMax;
                   _ -> max(RightMax, hd(T))
               end,
    NewResult = Result + max(0, min(NewLeftMax, RightMax) - H),
    trap(T, NewLeftMax, RightMax, NewResult).