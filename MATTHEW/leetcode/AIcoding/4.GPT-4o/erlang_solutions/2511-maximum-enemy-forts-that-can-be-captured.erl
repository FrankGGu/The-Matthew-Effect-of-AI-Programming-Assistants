-module(solution).
-export([capture_forts/1]).

capture_forts(Forts) ->
    Capture = fun(Forts, Dir) ->
        lists:foldl(fun
            (1, Acc) -> case Acc of
                {Captured, 0} -> {Captured + 1, 0};
                {Captured, _} -> {Captured, Acc}
            end;
            (-1, Acc) -> case Acc of
                {Captured, 0} -> {Captured + 1, 0};
                {Captured, _} -> {Captured, Acc}
            end;
            (0, Acc) -> {Acc#captured, 0}
        end, {0, 0}, lists:sublist(Forts, Dir))
    end,

    MaxCapture = lists:max([Capture(Forts, 1), Capture(lists:reverse(Forts), 1)]),

    MaxCapture.