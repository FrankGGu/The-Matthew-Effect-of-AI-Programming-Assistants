-module(minimum_operations_to_make_columns_strictly_increasing).
-export([min_deletion_size/1]).

min_deletion_size(strs) ->
  min_deletion_size(strs, 0).

min_deletion_size([], Acc) ->
  Acc;
min_deletion_size(Strs, Acc) ->
  case check_strictly_increasing(Strs) of
    true ->
      Acc;
    false ->
      Len = length(hd(Strs)),
      lists:min([min_deletion_size(delete_column(Strs, I), Acc + 1) || I <- lists:seq(1, Len)])
  end.

check_strictly_increasing([]) ->
  true;
check_strictly_increasing([_]) ->
  true;
check_strictly_increasing([H1, H2 | T]) ->
  case H1 < H2 of
    true ->
      check_strictly_increasing([H2 | T]);
    false ->
      false
  end.

delete_column([], _) ->
  [];
delete_column([Str | T], Index) ->
  [delete_char(Str, Index) | delete_column(T, Index)].

delete_char(Str, Index) ->
  delete_char(Str, Index, 1, []).

delete_char([], _, _, Acc) ->
  lists:reverse(Acc);
delete_char([H | T], Index, CurrentIndex, Acc) ->
  case Index =:= CurrentIndex of
    true ->
      delete_char(T, Index, CurrentIndex + 1, Acc);
    false ->
      delete_char(T, Index, CurrentIndex + 1, [H | Acc])
  end.