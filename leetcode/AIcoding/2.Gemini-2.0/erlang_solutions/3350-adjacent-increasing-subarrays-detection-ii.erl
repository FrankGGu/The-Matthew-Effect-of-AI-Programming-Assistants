-module(adjacent_increasing_subarrays2).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 0, 0, []).

solve([], _, Len, Acc) ->
  case Len > 0 of
    true -> lists:reverse([Len | Acc]);
    false -> lists:reverse(Acc)
  end;
solve([H], _, Len, Acc) ->
  case Len > 0 of
    true -> lists:reverse([Len | Acc]);
    false -> lists:reverse(Acc)
  end;
solve([H1, H2 | T], Start, Len, Acc) ->
  case H2 > H1 of
    true ->
      solve([H2 | T], Start, Len + 1, Acc);
    false ->
      case Len > 0 of
        true -> solve([H2 | T], 0, 0, [Len | Acc]);
        false -> solve([H2 | T], 0, 0, Acc)
      end.