-module(assign_cookies).
-export([find_content_children/2]).

find_content_children(G, S) ->
    SortedG = lists:sort(G),
    SortedS = lists:sort(S),
    find_content_children(SortedG, SortedS, 0, 0).

find_content_children([], _, _, _) ->
    0;
find_content_children(_, [], _, _) ->
    0;
find_content_children([G | Tg], [S | Ts], GCount, SCount) ->
    if
        G =< S ->
            find_content_children(Tg, Ts, GCount + 1, SCount + 1);
        true ->
            find_content_children(Tg, [S | Ts], GCount, SCount + 1)
    end.