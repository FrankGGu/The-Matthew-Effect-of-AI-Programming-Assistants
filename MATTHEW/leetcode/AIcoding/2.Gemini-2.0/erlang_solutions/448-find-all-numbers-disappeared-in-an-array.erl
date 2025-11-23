-module(find_disappeared_numbers).
-export([find_disappeared_numbers/1]).

find_disappeared_numbers(Nums) ->
  N = length(Nums),
  Map = lists:foldl(fun(Num, Acc) -> maps:put(Num, true, Acc) end, #{}, Nums),
  lists:foldl(
    fun(I, Acc) ->
      case maps:get(I, Map, false) of
        false -> [I | Acc];
        true -> Acc
      end
    end,
    [],
    lists:seq(1, N)
  ).