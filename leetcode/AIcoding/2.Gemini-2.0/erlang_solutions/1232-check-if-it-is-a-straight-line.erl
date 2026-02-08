-module(straight_line).
-export([check_straight_line/1]).

check_straight_line(Coordinates) ->
  case length(Coordinates) < 2 of
    true -> true;
    false ->
      [[X0, Y0], [X1, Y1] | Rest] = Coordinates,
      Slope = calculate_slope(X0, Y0, X1, Y1),
      check_rest(Rest, X0, Y0, Slope)
  end.

check_rest([], _, _, _) ->
  true.

check_rest([[X, Y] | Rest], X0, Y0, Slope) ->
  case Slope of
    infinity ->
      case X =:= X0 of
        true -> check_rest(Rest, X0, Y0, Slope);
        false -> false
      end;
    _ ->
      case abs( (Y - Y0) - Slope * (X - X0) ) < 1e-6 of
        true -> check_rest(Rest, X0, Y0, Slope);
        false -> false
      end
  end.

calculate_slope(X0, Y0, X1, Y1) ->
  case X1 - X0 =:= 0 of
    true -> infinity;
    false -> (Y1 - Y0) / (X1 - X0)
  end.