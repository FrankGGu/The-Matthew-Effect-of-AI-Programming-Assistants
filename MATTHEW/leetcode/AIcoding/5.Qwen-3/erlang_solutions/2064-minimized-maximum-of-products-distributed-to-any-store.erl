-module(minimized_max_products).
-export([solve/2]).

solve(Products, Stores) ->
    Left = lists:min(Products),
    Right = lists:max(Products),
    solve(Products, Stores, Left, Right).

solve(Products, Stores, Left, Right) when Left >= Right ->
    Left;
solve(Products, Stores, Left, Right) ->
    Mid = (Left + Right) div 2,
    case can_distribute(Products, Stores, Mid) of
        true ->
            solve(Products, Stores, Left, Mid);
        false ->
            solve(Products, Stores, Mid + 1, Right)
    end.

can_distribute([], _, _) ->
    true;
can_distribute([P | Ps], Stores, Max) ->
    Required = ceil(P / Max),
    if
        Stores < Required ->
            false;
        true ->
            can_distribute(Ps, Stores - Required, Max)
    end.

ceil(X) when X =< 0 ->
    0;
ceil(X) ->
    T = trunc(X),
    case X - T of
        0 -> T;
        _ -> T + 1
    end.