-module(relocate_marbles).
-export([relocate_marbles/2]).

relocate_marbles(nums, moves) ->
  Set = lists:foldl(fun(X, Acc) -> sets:add_element(X, Acc) end, sets:new(), nums),
  lists:foldl(fun({Move, To}, Acc) ->
                  case sets:is_element(Move, Acc) of
                    true ->
                      sets:del_element(Move, sets:add_element(To, Acc));
                    false ->
                      Acc
                  end
              end,
              Set,
              moves)
  |> sets:to_list()
  |> lists:sort().