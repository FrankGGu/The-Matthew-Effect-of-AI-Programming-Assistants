-module(count_largest_group).
-export([count_largest_group/1]).

count_largest_group(N) ->
  Groups = lists:foldl(
    fun(I, Acc) ->
      Sum = sum_digits(I),
      case maps:is_key(Sum, Acc) of
        true ->
          maps:update(Sum, maps:get(Sum, Acc) + 1, Acc);
        false ->
          maps:put(Sum, 1, Acc)
      end
    end,
    #{},
    lists:seq(1, N)
  ),
  MaxValue = lists:max(maps:values(Groups)),
  lists:foldl(
    fun(V, Count) ->
      if V == MaxValue then
        Count + 1
      else
        Count
      end
    end,
    0,
    maps:values(Groups)
  ).

sum_digits(N) ->
  sum_digits_helper(N, 0).

sum_digits_helper(0, Acc) ->
  Acc;
sum_digits_helper(N, Acc) ->
  sum_digits_helper(N div 10, Acc + (N rem 10)).