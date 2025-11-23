-module(longestConsecutive).
-export([longestConsecutive/1]).

longestConsecutive(Nums) ->
  Set = sets:from_list(Nums),
  lists:foldl(fun(Num, Acc) ->
                  case sets:is_element(Num - 1, Set) of
                    true ->
                      Acc;
                    false ->
                      Len = getLength(Set, Num, 1),
                      max(Acc, Len)
                  end
              end, 0, Nums).

getLength(Set, Num, Len) ->
  case sets:is_element(Num + 1, Set) of
    true ->
      getLength(Set, Num + 1, Len + 1);
    false ->
      Len
  end.