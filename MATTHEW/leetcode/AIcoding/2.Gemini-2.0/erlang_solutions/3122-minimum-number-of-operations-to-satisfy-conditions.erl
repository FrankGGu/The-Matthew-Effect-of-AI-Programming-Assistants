-module(minimum_operations).
-export([minimum_operations/1]).

minimum_operations(nums) ->
  minimum_operations(nums, 0).

minimum_operations([], Acc) ->
  Acc;
minimum_operations([A, B, C | Rest], Acc) ->
  case {A, B, C} of
    {1, 1, 1} ->
      minimum_operations(Rest, Acc + 1);
    {0, 0, 0} ->
      minimum_operations(Rest, Acc + 1);
    _ ->
      case count_ones([A, B, C]) of
        0 -> minimum_operations(Rest, Acc);
        1 -> minimum_operations(Rest, Acc);
        2 -> minimum_operations(Rest, Acc + 1);
        3 -> minimum_operations(Rest, Acc + 1)
      end
  end;
minimum_operations([A, B], Acc) ->
    case {A,B} of
        {1,1} -> Acc + 1;
        {0,0} -> Acc + 1;
        _ -> Acc
    end;
minimum_operations([A], Acc) ->
    Acc.

count_ones(List) ->
  count_ones(List, 0).

count_ones([], Acc) ->
  Acc;
count_ones([H | T], Acc) ->
  case H of
    1 ->
      count_ones(T, Acc + 1);
    _ ->
      count_ones(T, Acc)
  end.