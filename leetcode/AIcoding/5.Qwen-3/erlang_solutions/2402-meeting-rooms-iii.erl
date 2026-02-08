-module(meeting_rooms_iii).
-export([most_booked/1]).

most_booked(Events) ->
    lists:sort(fun({A, _}, {B, _}) -> A =< B end, Events),
    most_booked(Events, 0, [], []).

most_booked([], _Time, [], Rooms) ->
    lists:reverse(Rooms);
most_booked([], _Time, Heap, Rooms) ->
    [Room | _] = heap:pop(Heap),
    most_booked([], _Time, Heap, [Room | Rooms]);
most_booked([{Start, End} | T], Time, Heap, Rooms) ->
    if
        Start > Time ->
            most_booked(T, Start, Heap, Rooms);
        true ->
            {End, Room} = heap:pop(Heap),
            most_booked([{Start, End} | T], End, heap:push(Heap, {End, Room}), Rooms)
    end.

heap:push([], {E, R}) -> [{E, R}];
heap:push([{E, R} | T], {E2, R2}) when E2 < E -> [{E2, R2} | [{E, R} | T]];
heap:push([H | T], X) -> [H | heap:push(T, X)].

heap:pop([]) -> [];
heap:pop([H | T]) -> {H, T}.