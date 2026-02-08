-module(solution).
-export([pivot_integer/1]).

pivot_integer(N) ->
    SumTotal = N * (N + 1) div 2,
    XFloat = math:sqrt(SumTotal),
    X = round(XFloat),
    case X * X == SumTotal of
        true -> X;
        false -> -1
    end.