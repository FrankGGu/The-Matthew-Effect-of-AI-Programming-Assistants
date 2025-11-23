-module(reorder_list).
-export([reorderList/1]).

-spec reorderList(list()) -> list().
reorderList(L) ->
  {Half, Rest} = split(L),
  Reversed = reverse(Rest),
  merge(Half, Reversed).

split(L) ->
  split(L, L, []).

split([], _, Acc) -> {lists:reverse(Acc), []};
split([_], _, Acc) -> {lists:reverse(Acc), []};
split(L, [_], Acc) -> {lists:reverse(Acc), L};
split(L, [_, _], Acc) -> {lists:reverse(Acc), L};
split([H | T], [_, _ | TT], Acc) ->
  split(T, TT, [H | Acc]).

reverse(L) ->
  reverse(L, []).

reverse([], Acc) ->
  Acc;
reverse([H | T], Acc) ->
  reverse(T, [H | Acc]).

merge([], []) -> [];
merge([], L) -> L;
merge(L, []) -> L;
merge([H1 | T1], [H2 | T2]) ->
  [H1, H2 | merge(T1, T2)].