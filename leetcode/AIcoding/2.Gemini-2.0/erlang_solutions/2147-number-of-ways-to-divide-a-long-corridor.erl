-module(number_of_ways_to_divide_a_long_corridor).
-export([number_of_ways_to_divide_a_long_corridor/1]).

number_of_ways_to_divide_a_long_corridor(Corridor) ->
  number_of_ways(Corridor, 0, 0, 1).

number_of_ways([], _, _, Result) ->
  Result;

number_of_ways([H|T], Seats, Plants, Result) ->
  case H of
    $S ->
      case Seats of
        0 ->
          number_of_ways(T, Seats + 1, 0, Result);
        1 ->
          number_of_ways(T, Seats + 1, 0, Result);
        2 ->
          number_of_ways(T, 1, 0, (Result * (Plants + 1)) rem 1000000007)
      end;
    $P ->
      case Seats of
        2 ->
          number_of_ways(T, 2, Plants + 1, Result);
        _ ->
          number_of_ways(T, Seats, Plants + 1, Result)
      end
  end.