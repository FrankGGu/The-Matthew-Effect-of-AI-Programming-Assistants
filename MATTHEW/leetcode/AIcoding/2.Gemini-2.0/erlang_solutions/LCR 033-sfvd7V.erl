-module(group_anagrams).
-export([group_anagrams/1]).

group_anagrams(Strs) ->
  lists:foldl(
    fun(Str, Acc) ->
      SortedStr = lists:sort(string:to_list(Str)),
      case lists:keyfind(SortedStr, 1, Acc) of
        false ->
          [{SortedStr, [Str]} | Acc];
        {_, Group} ->
          lists:keyreplace(SortedStr, 1, Acc, {SortedStr, [Str | Group]})
      end
    end,
    [],
    Strs
  )
  |> lists:map(fun({_, Group}) -> Group end).