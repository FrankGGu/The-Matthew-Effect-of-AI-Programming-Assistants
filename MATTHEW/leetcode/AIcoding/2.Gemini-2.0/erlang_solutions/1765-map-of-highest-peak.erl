-module(highest_peak).
-export([highest_peak/1]).

highest_peak(IsWater) ->
  {Rows, Cols} = {length(IsWater), length(hd(IsWater))},
  Queue = [{R, C} || R <- lists:seq(0, Rows - 1), C <- lists:seq(0, Cols - 1), lists:nth(C+1, lists:nth(R+1, IsWater)) == 1],
  Dist = array:new([{size, {Rows, Cols}}, {default, -1}]),
  lists:foreach(fun({R, C}) -> array:set({R, C}, 0, Dist) end, Queue),
  bfs(Queue, Dist, Rows, Cols).

bfs([], Dist, _, _) ->
  Result = [[array:get({R, C}, Dist) || C <- lists:seq(0, Cols - 1)] || R <- lists:seq(0, Rows - 1)],
  Result;
bfs([{R, C} | Rest], Dist, Rows, Cols) ->
  Neighbors = get_neighbors(R, C, Rows, Cols),
  NewQueue = lists:foldl(fun({Nr, Nc}, Acc) ->
                          case array:get({Nr, Nc}, Dist) of
                            -1 ->
                              array:set({Nr, Nc}, array:get({R, C}, Dist) + 1, Dist),
                              [ {Nr, Nc} | Acc];
                            _ ->
                              Acc
                          end
                        end, Rest, Neighbors),
  bfs(NewQueue, Dist, Rows, Cols).

get_neighbors(R, C, Rows, Cols) ->
  Neighbors = [{R - 1, C}, {R + 1, C}, {R, C - 1}, {R, C + 1}],
  lists:filter(fun({Nr, Nc}) -> Nr >= 0 andalso Nr < Rows andalso Nc >= 0 andalso Nc < Cols end, Neighbors).