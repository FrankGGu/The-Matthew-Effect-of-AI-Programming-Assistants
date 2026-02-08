-module(insert_cyclic_sorted_list).
-export([insert/2]).

-spec insert(List :: list(), Val :: integer()) -> list().

insert([], Val) ->
  [Val, Val].

insert([H|T], Val) ->
  insert(H, T, Val).

insert(H, [], Val) ->
  [H, Val];

insert(H, [Next|T], Val) ->
  if
    Val >= H andalso Val <= Next ->
      [H, Val, Next | T];
    H > Next andalso (Val >= H orelse Val <= Next) ->
      [H, Val, Next | T];
    T == [] ->
      [H, Next, Val];
    true ->
      [H | insert(Next, T, Val)]
  end.