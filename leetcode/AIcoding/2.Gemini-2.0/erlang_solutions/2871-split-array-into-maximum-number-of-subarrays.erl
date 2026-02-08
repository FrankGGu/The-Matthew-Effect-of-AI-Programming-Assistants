-module(split_array).
-export([max_subarrays/1]).

max_subarrays(Nums) ->
  max_subarrays(Nums, 0, -1).

max_subarrays([], Acc, Last) ->
  case Last of
    -1 -> 0;
    _ -> Acc + 1
  end;
max_subarrays([H|T], Acc, Last) ->
  case Last of
    -1 ->
      max_subarrays(T, Acc, H);
    _ ->
      NewLast = Last band H;
      case NewLast of
        0 ->
          max_subarrays(T, Acc + 1, -1);
        _ ->
          max_subarrays(T, Acc, NewLast)
      end
  end.