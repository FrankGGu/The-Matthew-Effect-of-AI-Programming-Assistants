-module(frequency_sort).
-export([frequency_sort/1]).

frequency_sort(S) ->
  Frequencies = lists:foldl(
    fun(Char, Acc) ->
      maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
    end,
    #{},
    S
  ),
  SortedChars = lists:keysort(2, [{Char, Count} || {Char, Count} <- maps:to_list(Frequencies)]),
  lists:reverse(lists:foldl(
    fun({Char, Count}, Acc) ->
      Acc ++ lists:duplicate(Count, Char)
    end,
    [],
    SortedChars
  )).