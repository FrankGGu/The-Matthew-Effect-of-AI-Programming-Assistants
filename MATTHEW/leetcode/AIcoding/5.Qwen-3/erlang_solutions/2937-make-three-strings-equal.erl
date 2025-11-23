-module(solution).
-export([min_operations/3]).

min_operations(S, T, U) ->
    min_ops(S, T, U).

min_ops(S, T, U) ->
    [A, B, C] = lists:map(fun(X) -> string:to_lower(X) end, [S, T, U]),
    L = lists:foldl(fun(_, Acc) -> Acc + 1 end, 0, A),
    R = lists:foldl(fun(_, Acc) -> Acc + 1 end, 0, B),
    M = lists:foldl(fun(_, Acc) -> Acc + 1 end, 0, C),
    MinLen = lists:min([L, R, M]),
    Count = lists:foldl(fun(I, Acc) ->
        case (lists:nth(I, A) == lists:nth(I, B)) and (lists:nth(I, B) == lists:nth(I, C)) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(1, MinLen)),
    (MinLen - Count) * 3.