-module(solution).
-export([check_almost_equivalent/2]).

check_almost_equivalent(Word1, Word2) ->
  check_almost_equivalent(Word1, Word2, []).

check_almost_equivalent(Word1, Word2, Acc) ->
  Map1 = lists:foldl(fun(C, M) ->
                           case maps:is_key(C, M) of
                             true -> maps:update(C, maps:get(C, M) + 1, M);
                             false -> maps:put(C, 1, M)
                           end
                       end, #{}, string:to_list(Word1)),
  Map2 = lists:foldl(fun(C, M) ->
                           case maps:is_key(C, M) of
                             true -> maps:update(C, maps:get(C, M) + 1, M);
                             false -> maps:put(C, 1, M)
                           end
                       end, #{}, string:to_list(Word2)),

  check_diff(maps:keys(maps:merge(Map1, Map2)), Map1, Map2).

check_diff([], _, _) ->
  true;
check_diff([H|T], Map1, Map2) ->
  Count1 = maps:get(H, Map1, 0),
  Count2 = maps:get(H, Map2, 0),
  Diff = abs(Count1 - Count2),
  if
    Diff > 3 ->
      false;
    true ->
      check_diff(T, Map1, Map2)
  end.