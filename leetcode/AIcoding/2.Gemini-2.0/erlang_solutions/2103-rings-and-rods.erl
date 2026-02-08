-module(rings_and_rods).
-export([countPoints/1]).

countPoints(Rings) ->
  Map = lists:foldl(
    fun(<<Color:1, Rod:1>>, Acc) ->
      case maps:is_key(Rod - $0, Acc) of
        true ->
          maps:update(Rod - $0, sets:add_element(Color, maps:get(Rod - $0, Acc)), Acc);
        false ->
          maps:put(Rod - $0, sets:new([Color]), Acc)
      end
    end,
    #{},
    binary_to_list(Rings)
  ),
  lists:foldl(
    fun(Set, Count) ->
      case sets:is_element($R, Set) and sets:is_element($G, Set) and sets:is_element($B, Set) of
        true -> Count + 1;
        false -> Count
      end
    end,
    0,
    maps:values(Map)
  ).