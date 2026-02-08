-module(max_network_quality).
-export([max_network_quality/2]).

max_network_quality(Positions, Radius) ->
  {MaxX, MaxY} = lists:foldl(
    fun([X, Y], {MX, MY}) ->
      {max(MX, X), max(MY, Y)}
    end,
    {0, 0},
    Positions
  ),

  MaxQuality = lists:foldl(
    fun(X, Acc) ->
      lists:foldl(
        fun(Y, Acc2) ->
          Quality = calculate_quality(X, Y, Positions, Radius),
          max(Acc2, Quality)
        end,
        Acc,
        lists:seq(0, MaxY)
      )
    end,
    0,
    lists:seq(0, MaxX)
  ),

  find_coordinate(Positions, Radius, MaxQuality, 0, 0, MaxX, MaxY, []) .

find_coordinate(Positions, Radius, MaxQuality, X, Y, MaxX, MaxY, Acc) ->
  case X > MaxX of
    true ->
      lists:foldl(fun({XCoord, YCoord}, Best) ->
                        case calculate_quality(XCoord,YCoord,Positions,Radius) =:= MaxQuality of
                          true ->
                            case Best =:= [] of
                              true -> {XCoord, YCoord};
                              false ->
                                {BXCoord, BYCoord} = Best,
                                case {XCoord, YCoord} < {BXCoord, BYCoord} of
                                  true -> {XCoord,YCoord};
                                  false -> Best
                                end
                            end;
                          false ->
                            Best
                        end
                    end, [], Acc);
    false ->
      Quality = calculate_quality(X, Y, Positions, Radius),
      case Quality =:= MaxQuality of
        true ->
          NewAcc = [{X, Y} | Acc];
          case Y >= MaxY of
            true ->
                find_coordinate(Positions, Radius, MaxQuality, X + 1, 0, MaxX, MaxY, NewAcc);
            false ->
                find_coordinate(Positions, Radius, MaxQuality, X, Y + 1, MaxX, MaxY, NewAcc)
          end;
        false ->
          case Y >= MaxY of
            true ->
              find_coordinate(Positions, Radius, MaxQuality, X + 1, 0, MaxX, MaxY, Acc);
            false ->
              find_coordinate(Positions, Radius, MaxQuality, X, Y + 1, MaxX, MaxY, Acc)
          end
      end
  end.

calculate_quality(X, Y, Positions, Radius) ->
  lists:foldl(
    fun([PX, PY, Q], Acc) ->
      Distance = math:sqrt(math:pow(X - PX, 2) + math:pow(Y - PY, 2)),
      case Distance =< Radius of
        true ->
          Acc + floor(Q / (1 + Distance));
        false ->
          Acc
      end
    end,
    0,
    Positions
  ).