-module(solution).

-export([init/1, pick/0]).

-record(rect, {x1, y1, x2, y2, area}).

init(Rects) ->
    Rects1 = lists:map(fun([X1, Y1, X2, Y2]) ->
        Area = (X2 - X1 + 1) * (Y2 - Y1 + 1),
        #rect{x1 = X1, y1 = Y1, x2 = X2, y2 = Y2, area = Area}
    end, Rects),
    Areas = lists:map(fun(R) -> R#rect.area end, Rects1),
    Total = lists:sum(Areas),
    {Rects1, Areas, Total}.

pick() ->
    {Rects, Areas, Total} = get(solution_state),
    Rand = rand:uniform(Total),
    {Rect, _} = select_rect(Rects, Areas, Rand),
    X = Rect#rect.x1 + rand:uniform(Rect#rect.x2 - Rect#rect.x1 + 1) - 1,
    Y = Rect#rect.y1 + rand:uniform(Rect#rect.y2 - Rect#rect.y1 + 1) - 1,
    [X, Y].

select_rect([Rect | Rects], [Area | Areas], Rand) ->
    if
        Rand =< Area -> {Rect, 0};
        true -> select_rect(Rects, Areas, Rand - Area)
    end.