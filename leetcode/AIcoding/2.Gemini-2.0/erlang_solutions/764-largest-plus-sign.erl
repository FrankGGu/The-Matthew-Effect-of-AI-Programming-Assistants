-module(largest_plus_sign).
-export([orderOfLargestPlusSign/2]).

orderOfLargestPlusSign(N, Mines) ->
  Grid = array:new({0, 0}, {N - 1, N - 1}, 1),
  MinedGrid = lists:foldl(fun({Row, Col}, Acc) -> array:set({Row, Col}, 0, Acc) end, Grid, Mines),

  Left = array:new({0, 0}, {N - 1, N - 1}, 0),
  Right = array:new({0, 0}, {N - 1, N - 1}, 0),
  Up = array:new({0, 0}, {N - 1, N - 1}, 0),
  Down = array:new({0, 0}, {N - 1, N - 1}, 0),

  Left1 = lists:foldl(
    fun({Row, Col}, Acc) ->
      if array:get({Row, Col}, MinedGrid) == 1 ->
        if Col > 0 then
          array:set({Row, Col}, array:get({Row, Col - 1}, Acc) + 1, Acc)
        else
          array:set({Row, Col}, 1, Acc)
        end
      else
        array:set({Row, Col}, 0, Acc)
      end
    end, Left, lists:flatten([[{Row, Col} || Col <- lists:seq(0, N - 1)] || Row <- lists:seq(0, N - 1)])
  ),

  Right1 = lists:foldl(
    fun({Row, Col}, Acc) ->
      if array:get({Row, Col}, MinedGrid) == 1 ->
        if Col < N - 1 then
          array:set({Row, Col}, array:get({Row, Col + 1}, Acc) + 1, Acc)
        else
          array:set({Row, Col}, 1, Acc)
        end
      else
        array:set({Row, Col}, 0, Acc)
      end
    end, Right, lists:reverse(lists:flatten([[{Row, Col} || Col <- lists:seq(0, N - 1)] || Row <- lists:seq(0, N - 1)]))
  ),

  Up1 = lists:foldl(
    fun({Row, Col}, Acc) ->
      if array:get({Row, Col}, MinedGrid) == 1 ->
        if Row > 0 then
          array:set({Row, Col}, array:get({Row - 1, Col}, Acc) + 1, Acc)
        else
          array:set({Row, Col}, 1, Acc)
        end
      else
        array:set({Row, Col}, 0, Acc)
      end
    end, Up, lists:flatten([[{Row, Col} || Col <- lists:seq(0, N - 1)] || Row <- lists:seq(0, N - 1)])
  ),

  Down1 = lists:foldl(
    fun({Row, Col}, Acc) ->
      if array:get({Row, Col}, MinedGrid) == 1 ->
        if Row < N - 1 then
          array:set({Row, Col}, array:get({Row + 1, Col}, Acc) + 1, Acc)
        else
          array:set({Row, Col}, 1, Acc)
        end
      else
        array:set({Row, Col}, 0, Acc)
      end
    end, Down, lists:reverse(lists:flatten([[{Row, Col} || Col <- lists:seq(0, N - 1)] || Row <- lists:seq(0, N - 1)]))
  ),

  MaxOrder = lists:foldl(
    fun({Row, Col}, Acc) ->
      Val = min([array:get({Row, Col}, Left1), array:get({Row, Col}, Right1), array:get({Row, Col}, Up1), array:get({Row, Col}, Down1)]);
      max(Acc, Val)
    end, 0, lists:flatten([[{Row, Col} || Col <- lists:seq(0, N - 1)] || Row <- lists:seq(0, N - 1)])
  ),

  MaxOrder.