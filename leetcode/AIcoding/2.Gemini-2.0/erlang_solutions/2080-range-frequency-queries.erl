-module(range_frequency).
-export([new/1, query/3]).

new(Arr) ->
  lists:foldl(fun(Elem, Acc) ->
                  case maps:is_key(Elem, Acc) of
                    true ->
                      maps:update(Elem, Acc[Elem] ++ [lists:seq(1,length(Acc[Elem]))[-1] + 1], Acc);
                    false ->
                      maps:put(Elem, [1], Acc)
                  end
              end, #{}, Arr).

query(Obj, Left, Right, Value) ->
  case maps:is_key(Value, Obj) of
    true ->
      PosList = Obj[Value],
      L = binary_search_left(PosList, Left + 1),
      R = binary_search_right(PosList, Right + 1),
      R - L + 1;
    false ->
      0
  end.

binary_search_left(Arr, Target) ->
  binary_search_left(Arr, Target, 1, length(Arr)).

binary_search_left(_Arr, _Target, L, R) when L > R ->
  L;
binary_search_left(Arr, Target, L, R) ->
  Mid = (L + R) div 2,
  if
    lists:nth(Mid, Arr) >= Target ->
      binary_search_left(Arr, Target, L, Mid - 1);
    true ->
      binary_search_left(Arr, Target, Mid + 1, R)
  end.

binary_search_right(Arr, Target) ->
  binary_search_right(Arr, Target, 1, length(Arr)).

binary_search_right(_Arr, _Target, L, R) when L > R ->
  R;
binary_search_right(Arr, Target, L, R) ->
  Mid = (L + R) div 2,
  if
    lists:nth(Mid, Arr) > Target ->
      binary_search_right(Arr, Target, L, Mid - 1);
    true ->
      binary_search_right(Arr, Target, Mid + 1, R)
  end.