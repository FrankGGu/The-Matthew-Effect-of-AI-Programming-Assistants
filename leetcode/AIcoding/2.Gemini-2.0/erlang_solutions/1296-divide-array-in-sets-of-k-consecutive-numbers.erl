-module(divide_array).
-export([is_possible_divide/2]).

is_possible_divide(Nums, K) ->
  Len = length(Nums),
  if Len rem K /= 0 ->
    false
  else
    Counts = lists:foldl(fun(N, Acc) ->
                             case maps:get(N, Acc, undefined) of
                               undefined ->
                                 maps:put(N, 1, Acc);
                               Count ->
                                 maps:put(N, Count + 1, Acc)
                             end
                         end, #{}, Nums),
    is_possible_divide_helper(Counts, K)
  end.

is_possible_divide_helper(Counts, K) ->
  case maps:is_empty(Counts) of
    true ->
      true;
    false ->
      {MinNum, _} = lists:min([ {Num, Count} || {Num, Count} <- maps:to_list(Counts) ]),
      NewCounts = try_remove_consecutive(Counts, MinNum, K),
      case NewCounts of
        error ->
          false;
        NewCountsMap ->
          is_possible_divide_helper(NewCountsMap, K)
      end
  end.

try_remove_consecutive(Counts, Start, K) ->
  try
    NewCounts = lists:foldl(fun(I, Acc) ->
                               Num = Start + I,
                               case maps:get(Num, Acc, undefined) of
                                 undefined ->
                                   throw(error);
                                 1 ->
                                   maps:remove(Num, Acc);
                                 Count ->
                                   maps:put(Num, Count - 1, Acc)
                               end
                           end, Counts, lists:seq(0, K - 1)),
    {ok, NewCounts}
  catch
    error:_ ->
      error
  end.