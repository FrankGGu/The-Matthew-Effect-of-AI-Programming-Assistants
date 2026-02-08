-module(odd_cells).
-export([odd_cells/3]).

odd_cells(N, M, Indices) ->
  RowCounts = lists:foldl(fun([R, _], Acc) ->
                                  maps:update_with(R, fun(V) -> V + 1 end, 1, Acc)
                              end, #{}, Indices),
  ColCounts = lists:foldl(fun([_, C], Acc) ->
                                  maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                              end, #{}, Indices),

  lists:foldl(fun(R, Count) ->
                  lists:foldl(fun(C, Acc) ->
                                  RowVal = maps:get(R, RowCounts, 0),
                                  ColVal = maps:get(C, ColCounts, 0),
                                  if (RowVal + ColVal) rem 2 == 1 ->
                                    Acc + 1;
                                  true ->
                                    Acc
                                  end
                              end, Count, lists:seq(0, M - 1))
              end, 0, lists:seq(0, N - 1)).