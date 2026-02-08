-module(largest_local).
-export([largestLocal/1]).

largestLocal(Grid) ->
  N = length(Grid),
  NewN = N - 2,
  NewGrid = lists:map(fun(_) -> lists:duplicate(NewN, 0) end, lists:seq(1, NewN)),

  lists:foreach(
    fun(I) ->
      lists:foreach(
        fun(J) ->
          MaxVal = findMax(Grid, I, J),
          lists:nth(I - 1, NewGrid) ! {J - 1, MaxVal}
        end,
        lists:seq(2, N - 1)
      )
    end,
    lists:seq(2, N - 1)
  ),

  Result = lists:map(fun(Row) ->
    lists:foldl(fun({Col, Val}, Acc) ->
      lists:nth(Col + 1, Row) ! Val,
      Acc
    end, Row, lists:seq(1, NewN))
  end, NewGrid),

  lists:map(fun(Row) ->
    lists:map(fun(Element) ->
      receive
        Val -> Val
      end
    end, Row)
  end, Result).

findMax(Grid, I, J) ->
  lists:max([
    lists:nth(J - 1, lists:nth(I - 1, Grid)),
    lists:nth(J, lists:nth(I - 1, Grid)),
    lists:nth(J + 1, lists:nth(I - 1, Grid)),
    lists:nth(J - 1, lists:nth(I, Grid)),
    lists:nth(J, lists:nth(I, Grid)),
    lists:nth(J + 1, lists:nth(I, Grid)),
    lists:nth(J - 1, lists:nth(I + 1, Grid)),
    lists:nth(J, lists:nth(I + 1, Grid)),
    lists:nth(J + 1, lists:nth(I + 1, Grid))
  ]).