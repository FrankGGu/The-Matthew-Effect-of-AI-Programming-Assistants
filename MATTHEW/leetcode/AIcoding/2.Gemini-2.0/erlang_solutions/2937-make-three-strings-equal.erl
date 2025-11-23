-module(make_three_strings_equal).
-export([min_operations/3]).

min_operations(S1, S2, S3) ->
  min_operations_helper(string:to_list(S1), string:to_list(S2), string:to_list(S3), 0).

min_operations_helper(S1, S2, S3, Count) ->
  Len1 = length(S1),
  Len2 = length(S2),
  Len3 = length(S3),

  case find_common_prefix(S1, S2, S3) of
    "" ->
      Len1 + Len2 + Len3;
    Prefix ->
      PrefixLen = length(Prefix),
      Len1 + Len2 + Len3 - 3 * PrefixLen
  end.

find_common_prefix(S1, S2, S3) ->
  find_common_prefix_helper(S1, S2, S3, []).

find_common_prefix_helper([], _, _, Acc) ->
  lists:reverse(Acc);
find_common_prefix_helper(_, [], _, Acc) ->
  lists:reverse(Acc);
find_common_prefix_helper(_, _, [], Acc) ->
  lists:reverse(Acc);
find_common_prefix_helper([H1|T1], [H2|T2], [H3|T3], Acc) ->
  case H1 =:= H2 andalso H2 =:= H3 of
    true ->
      find_common_prefix_helper(T1, T2, T3, [H1|Acc]);
    false ->
      lists:reverse(Acc)
  end.