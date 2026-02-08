-module(minimum_distance_to_target).
-export([find_closest/3]).

find_closest(Nums, Target, Start) ->
  find_closest(Nums, Target, Start, 0, length(Nums) - 1).

find_closest(Nums, Target, Start, Min, Max) ->
  find_closest(Nums, Target, Start, Min, Max, infinity).

find_closest(_Nums, _Target, _Start, Min, Max, Acc) when Min > Max ->
  Acc;
find_closest(Nums, Target, Start, Min, Max, Acc) ->
  case lists:nth(Min + 1, Nums) == Target of
    true ->
      find_closest(Nums, Target, Start, Min + 1, Max, min(abs(Min - Start), Acc));
    false ->
      case lists:nth(Max + 1, Nums) == Target of
        true ->
          find_closest(Nums, Target, Start, Min + 1, Max - 1, min(abs(Max - Start), Acc));
        false ->
          find_closest(Nums, Target, Start, Min + 1, Max - 1, Acc)
      end
  end.

min(A, B) when A < B -> A;
min(_, B) -> B.

infinity() -> 1000000000.