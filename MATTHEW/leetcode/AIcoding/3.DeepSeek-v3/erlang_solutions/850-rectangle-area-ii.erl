-module(rectangle_area).

-export([rectangle_area/1]).

rectangle_area(Rectangles) ->
    Events = lists:flatmap(fun([X1, Y1, X2, Y2]) ->
        [{X1, 1, Y1, Y2}, {X2, -1, Y1, Y2}]
    end, Rectangles),
    SortedEvents = lists:sort(fun({X1, _, _, _}, {X2, _, _, _}) -> X1 =< X2 end, Events),
    scan(SortedEvents, 0, 0, 0, []).

scan([], _PrevX, _Active, Area, _ActiveYs) ->
    Area;
scan([{X, Type, Y1, Y2} | Rest], PrevX, Active, Area, ActiveYs) ->
    DeltaX = X - PrevX,
    CurrentArea = if DeltaX > 0 -> Area + DeltaX * calculate_active_length(ActiveYs); true -> Area end,
    NewActiveYs = update_active_ys(Y1, Y2, Type, ActiveYs),
    NewActive = Active + Type,
    scan(Rest, X, NewActive, CurrentArea, NewActiveYs).

update_active_ys(Y1, Y2, Type, ActiveYs) ->
    case Type of
        1 -> insert(Y1, Y2, ActiveYs);
        -1 -> delete(Y1, Y2, ActiveYs)
    end.

insert(Y1, Y2, []) ->
    [{Y1, Y2}];
insert(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 < CurY1 ->
    [{Y1, Y2}, {CurY1, CurY2} | Rest];
insert(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 =< CurY2 andalso Y2 > CurY2 ->
    insert(Y1, CurY2, Rest);
insert(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 > CurY2 ->
    [{CurY1, CurY2} | insert(Y1, Y2, Rest)];
insert(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y2 =< CurY2 ->
    [{CurY1, CurY2} | Rest].

delete(Y1, Y2, []) ->
    [];
delete(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 =:= CurY1 andalso Y2 =:= CurY2 ->
    Rest;
delete(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 =:= CurY1 andalso Y2 < CurY2 ->
    [{Y2, CurY2} | Rest];
delete(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 > CurY1 andalso Y2 =:= CurY2 ->
    [{CurY1, Y1} | Rest];
delete(Y1, Y2, [{CurY1, CurY2} | Rest]) when Y1 > CurY1 andalso Y2 < CurY2 ->
    [{CurY1, Y1}, {Y2, CurY2} | Rest];
delete(Y1, Y2, [{CurY1, CurY2} | Rest]) ->
    [{CurY1, CurY2} | delete(Y1, Y2, Rest)].

calculate_active_length(ActiveYs) ->
    lists:foldl(fun({Y1, Y2}, Acc) -> Acc + (Y2 - Y1) end, 0, ActiveYs).