-module(min_ascii_delete_sum).
-export([minimum_delete_sum/2]).

minimum_delete_sum(S1, S2) ->
  S1_list = string:to_list(S1),
  S2_list = string:to_list(S2),
  minimum_delete_sum_helper(S1_list, S2_list).

minimum_delete_sum_helper(S1, S2) ->
  Len1 = length(S1),
  Len2 = length(S2),
  DP = array:new([Len1 + 1, Len2 + 1]),

  array:set({0, 0}, 0, DP),

  lists:foreach(fun(I) ->
                  array:set({I + 1, 0}, array:get({I, 0}, DP) + lists:nth(I + 1, S1), DP)
                end, lists:seq(0, Len1 - 1)),

  lists:foreach(fun(J) ->
                  array:set({0, J + 1}, array:get({0, J}, DP) + lists:nth(J + 1, S2), DP)
                end, lists:seq(0, Len2 - 1)),

  lists:foreach(fun(I) ->
                  lists:foreach(fun(J) ->
                                  if
                                    lists:nth(I + 1, S1) == lists:nth(J + 1, S2) ->
                                      array:set({I + 1, J + 1}, array:get({I, J}, DP), DP);
                                    true ->
                                      array:set({I + 1, J + 1}, min(array:get({I, J + 1}, DP) + lists:nth(I + 1, S1),
                                                                    array:get({I + 1, J}, DP) + lists:nth(J + 1, S2)), DP)
                                  end
                                end, lists:seq(0, Len2 - 1))
                end, lists:seq(0, Len1 - 1)),

  array:get({Len1, Len2}, DP).

min(A, B) ->
  if A < B -> A; true -> B end.