-module(solution).
-export([max_area/3]).

max_area(H, W, Cuts) ->
    VerticalCuts = lists:filter(fun(X) -> X < W end, Cuts),
    HorizontalCuts = lists:filter(fun(X) -> X < H end, Cuts),
    MaxVertical = case VerticalCuts of
        [] -> W;
        _ -> lists:max(VerticalCuts) - lists:min([0 | VerticalCuts])
    end,
    MaxHorizontal = case HorizontalCuts of
        [] -> H;
        _ -> lists:max(HorizontalCuts) - lists:min([0 | HorizontalCuts])
    end,
    (MaxVertical * MaxHorizontal) rem (10^9 + 7).