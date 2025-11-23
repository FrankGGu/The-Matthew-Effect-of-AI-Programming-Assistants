-module(keys_and_rooms).
-export([canVisitAllRooms/1]).

canVisitAllRooms(Rooms) ->
  canVisitAllRooms(Rooms, [0], sets:new(), 0).

canVisitAllRooms(Rooms, Queue, Visited, Count) ->
  case Queue of
    [] ->
      Count + 1 == length(Rooms);
    [Room | Rest] ->
      case sets:is_element(Room, Visited) of
        true ->
          canVisitAllRooms(Rooms, Rest, Visited, Count);
        false ->
          Keys = lists:nth(Room + 1, Rooms),
          NewQueue = Rest ++ lists:filter(fun(Key) -> not sets:is_element(Key, sets:add_element(Room, Visited)) end, Keys),
          canVisitAllRooms(Rooms, NewQueue, sets:add_element(Room, Visited), Count + 1)
      end
  end.