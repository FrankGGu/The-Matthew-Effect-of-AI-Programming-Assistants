-module(collect_fruits).
-export([max_total_fruits/2]).

max_total_fruits(Fruits, K) ->
  max_total_fruits(Fruits, K, 0, 0, 0).

max_total_fruits([], _K, MaxSoFar, _L, _R) ->
  MaxSoFar;
max_total_fruits(Fruits, K, MaxSoFar, L, R) ->
  max_total_fruits(Fruits, K, MaxSoFar, L, R, 0).

max_total_fruits(Fruits, K, MaxSoFar, L, R, I) when I >= length(Fruits) ->
  MaxSoFar;
max_total_fruits(Fruits, K, MaxSoFar, L, R, I) ->
  {Pos, Count} = lists:nth(I, Fruits),
  case L == 0 of
    true ->
      max_total_fruits(Fruits, K, max(MaxSoFar, Count), Pos, Pos, I + 1);
    false ->
      case R == Pos of
        true ->
          max_total_fruits(Fruits, K,
            max(MaxSoFar, Count + sum_fruits(Fruits, L, R)), L, R, I + 1);
        false ->
          case abs(Pos - L) <= K of
            true ->
              max_total_fruits(Fruits, K,
                max(MaxSoFar, Count + sum_fruits(Fruits, L, Pos)), L, Pos, I + 1);
            false ->
              case abs(Pos - R) <= K of
                true ->
                  max_total_fruits(Fruits, K,
                    max(MaxSoFar, Count + sum_fruits(Fruits, Pos, R)), Pos, R, I + 1);
                false ->
                  MaxSoFar
              end
          end
      end
  end.

sum_fruits(Fruits, L, R) ->
  sum_fruits(Fruits, L, R, 0).

sum_fruits([], _L, _R, Sum) ->
  Sum;
sum_fruits(Fruits, L, R, Sum) ->
  sum_fruits(Fruits, L, R, Sum, 1, Fruits).

sum_fruits(_L, _R, Sum, _Index, []) ->
  Sum;
sum_fruits(L, R, Sum, Index, [{Pos, Count} | Rest]) ->
  case Pos >= L andalso Pos =< R of
    true ->
      sum_fruits(L, R, Sum + Count, Index + 1, Rest);
    false ->
      sum_fruits(L, R, Sum, Index + 1, Rest)
  end.

sum_fruits(Fruits, L, R, Sum, Index, List) when Index > length(Fruits) ->
  Sum.

sum_fruits(Fruits, L, R, Sum, Index, List) ->
  {Pos, Count} = lists:nth(Index, List),
  case Pos >= L andalso Pos =< R of
    true ->
      sum_fruits(Fruits, L, R, Sum + Count, Index + 1, List);
    false ->
      sum_fruits(Fruits, L, R, Sum, Index + 1, List)
  end.

sum_fruits(Fruits, L, R, Sum, Index, List) ->
  try
    {Pos, Count} = lists:nth(Index, List),
    case Pos >= L andalso Pos =< R of
      true ->
        sum_fruits(Fruits, L, R, Sum + Count, Index + 1, List);
      false ->
        sum_fruits(Fruits, L, R, Sum, Index + 1, List)
    end
  catch
    error:badarg ->
      Sum
  end.

sum_fruits(Fruits, L, R) ->
  lists:sum([Count || {Pos, Count} <- Fruits, Pos >= L, Pos =< R]).