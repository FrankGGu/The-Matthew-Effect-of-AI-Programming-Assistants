-module(solution).
-export([number_of_subarrays/1]).

number_of_subarrays(Nums) ->
  number_of_subarrays(Nums, 0).

number_of_subarrays([], Acc) ->
  Acc;
number_of_subarrays([H|T], Acc) ->
  number_of_subarrays([H|T], H, 0, Acc).

number_of_subarrays([H|T], Max, CurrentLen, Acc) ->
  case T of
    [] ->
      Acc + count_subarrays(H, Max, CurrentLen + 1);
    [Next|Rest] ->
      if
        Next > Max ->
          number_of_subarrays([Next|Rest], Next, 0, Acc + count_subarrays(H, Max, CurrentLen + 1));
        true ->
          number_of_subarrays([Next|Rest], Max, CurrentLen + 1, Acc)
      end
  end.

count_subarrays(H, Max, Len) ->
  if H =:= Max, Len > 0 ->
    Len;
  true ->
    0
  end.