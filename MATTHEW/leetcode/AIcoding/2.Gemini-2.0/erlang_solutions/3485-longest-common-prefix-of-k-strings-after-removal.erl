-module(longest_common_prefix_removal).
-export([longestCommonPrefix/1]).

longestCommonPrefix(Strs) ->
  case Strs of
    [] -> "";
    _ ->
      lists:foldl(fun(Str, Acc) -> commonPrefix(Str, Acc) end, hd(Strs), tl(Strs))
  end.

commonPrefix(Str1, Str2) ->
  commonPrefixHelper(Str1, Str2, []).

commonPrefixHelper([], _, Acc) ->
  lists:reverse(Acc);
commonPrefixHelper(_, [], Acc) ->
  lists:reverse(Acc);
commonPrefixHelper([H1|T1], [H2|T2], Acc) ->
  case H1 =:= H2 of
    true -> commonPrefixHelper(T1, T2, [H1|Acc]);
    false -> lists:reverse(Acc)
  end.