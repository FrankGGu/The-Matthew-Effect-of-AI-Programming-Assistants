-module(maximum_number_of_balloons).
-export([max_number_of_balloons/1]).

max_number_of_balloons(Text) ->
  Counts = lists:foldl(fun(C, Acc) ->
                           case maps:is_key(C, Acc) of
                             true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
                             false -> maps:put(C, 1, Acc)
                           end
                         end, #{}, Text),

  B = maps:get(<<"b">>, Counts, 0),
  A = maps:get(<<"a">>, Counts, 0),
  L = maps:get(<<"l">>, Counts, 0) div 2,
  O = maps:get(<<"o">>, Counts, 0) div 2,
  N = maps:get(<<"n">>, Counts, 0),

  min([B, A, L, O, N]).