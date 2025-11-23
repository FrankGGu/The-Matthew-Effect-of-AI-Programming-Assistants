-module(minimum_right_shifts).
-export([minimum_right_shifts/1]).

minimum_right_shifts(Nums) ->
  minimum_right_shifts(Nums, 0).

minimum_right_shifts(Nums, Shift) ->
  case is_sorted(rotate_right(Nums, Shift)) of
    true ->
      Shift;
    false ->
      case Shift + 1 < length(Nums) of
        true ->
          minimum_right_shifts(Nums, Shift + 1);
        false ->
          -1
      end
  end.

rotate_right(Nums, Shift) ->
  Len = length(Nums),
  lists:sublist(lists:nthtail(Len - Shift, Nums), Shift) ++ lists:sublist(Nums, Len - Shift).

is_sorted([]) ->
  true;
is_sorted([_]) ->
  true;
is_sorted([H1, H2 | T]) ->
  case H1 =< H2 of
    true ->
      is_sorted([H2 | T]);
    false ->
      false
  end.