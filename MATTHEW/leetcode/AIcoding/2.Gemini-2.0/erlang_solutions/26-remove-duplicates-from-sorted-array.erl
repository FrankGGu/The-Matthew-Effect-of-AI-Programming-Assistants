-module(remove_duplicates).
-export([remove_duplicates/1]).

remove_duplicates(Nums) ->
  remove_duplicates(Nums, 0, 0, []).

remove_duplicates([], _, Len, Acc) ->
  {Len, lists:reverse(Acc)};
remove_duplicates([H|T], Index, Len, Acc) ->
  case Acc of
    [] ->
      remove_duplicates(T, Index + 1, Len + 1, [H]);
    [Last|_] ->
      if H == Last then
        remove_duplicates(T, Index + 1, Len, Acc)
      else
        remove_duplicates(T, Index + 1, Len + 1, [H|Acc])
      end
  end.

remove_duplicates(Nums) ->
  {Len, Result} = remove_duplicates(Nums, 0, 0, []),
  {Len, lists:sublist(Result, Len)}.