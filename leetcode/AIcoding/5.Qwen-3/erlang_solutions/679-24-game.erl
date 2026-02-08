-module(solution).
-export([find_target/1]).

find_target(Numbers) ->
    find_target(Numbers, 24).

find_target([], _) -> false;
find_target([N], Target) -> abs(N - Target) < 0.000001;
find_target(Numbers, Target) ->
    lists:any(fun(I) ->
        lists:any(fun(J) ->
            if
                I == J -> false;
                true ->
                    A = lists:nth(I, Numbers),
                    B = lists:nth(J, Numbers),
                    Remaining = lists:delete(A, lists:delete(B, Numbers)),
                    C = A + B,
                    D = A - B,
                    E = B - A,
                    F = A * B,
                    G = case B of
                        0 -> infinity;
                        _ -> A / B
                    end,
                    H = case A of
                        0 -> infinity;
                        _ -> B / A
                    end,
                    lists:any(fun(X) -> find_target([X | Remaining], Target) end, [C, D, E, F, G, H])
            end
        end, lists:seq(1, length(Numbers))) end, lists:seq(1, length(Numbers))).