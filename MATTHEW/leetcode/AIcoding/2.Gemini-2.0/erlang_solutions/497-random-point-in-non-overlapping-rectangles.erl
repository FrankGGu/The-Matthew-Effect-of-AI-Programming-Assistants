-module(random_rectangles).
-export([new/1, pick/1]).

-record(state, {rects, areas, total_area}).

new(Rects) ->
    {Areas, TotalArea} = calculate_areas(Rects, 0, []),
    State = #state{rects = Rects, areas = lists:reverse(Areas), total_area = TotalArea},
    State.

pick(State) ->
    Rand = random:uniform() * State#state.total_area,
    {Rect, AccArea} = find_rectangle(State#state.areas, Rand, 0),
    [X1, Y1, X2, Y2] = Rect,
    Width = X2 - X1 + 1,
    Height = Y2 - Y1 + 1,
    X = X1 + trunc(random:uniform() * Width),
    Y = Y1 + trunc(random:uniform() * Height),
    [X, Y].

calculate_areas([], Acc, Areas) ->
    {Areas, Acc};
calculate_areas([Rect | Rest], Acc, Areas) ->
    [X1, Y1, X2, Y2] = Rect,
    Area = (X2 - X1 + 1) * (Y2 - Y1 + 1),
    calculate_areas(Rest, Acc + Area, [Acc + Area | Areas]).

find_rectangle([Area | Rest], Rand, Acc) ->
    if Rand =< Area ->
        {lists:nth(length(Rest) + 1, lists:reverse(State#state.rects)), Acc};
    true ->
        find_rectangle(Rest, Rand, Area)
    end.