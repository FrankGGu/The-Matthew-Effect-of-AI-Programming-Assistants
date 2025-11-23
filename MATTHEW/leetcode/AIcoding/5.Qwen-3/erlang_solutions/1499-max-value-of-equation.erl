-module(max_value_of_equation).
-export([maxValueOfEquation/1]).

maxValueOfEquation(Points) ->
    max_value_of_equation(Points, -infinity, [], 0).

max_value_of_equation([], _Max, _Deque, _I) ->
    case _Max of
        -infinity -> -infinity;
        _ -> _Max
    end;

max_value_of_equation([Point | Rest], Max, Deque, I) ->
    {X, Y} = Point,
    while_deque(Deque, X),
    Current = Y + X,
    NewMax = if
        Max == -infinity -> Current;
        true -> max(Max, Current)
    end,
    NewDeque = add_to_deque(Deque, {X, Y, I}),
    max_value_of_equation(Rest, NewMax, NewDeque, I + 1).

while_deque([], _) -> ok;
while_deque([H | T], X) ->
    {HX, HY, HI} = H,
    if
        X - HI > 100000 -> while_deque(T, X);
        true -> ok
    end.

add_to_deque(Deque, {X, Y, I}) ->
    add_to_deque(Deque, {X, Y, I}, []).

add_to_deque([], Item, Acc) ->
    lists:reverse([Item | Acc]);

add_to_deque([H | T], Item, Acc) ->
    {HX, HY, HI} = H,
    {IX, IY, II} = Item,
    if
        HY - IY < 0 -> add_to_deque(T, Item, [H | Acc]);
        true -> add_to_deque(T, Item, [H | Acc])
    end.