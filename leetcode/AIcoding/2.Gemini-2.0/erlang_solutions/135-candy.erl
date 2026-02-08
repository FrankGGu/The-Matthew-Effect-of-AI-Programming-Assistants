-module(candy).
-export([candy/1]).

candy(Ratings) ->
  N = length(Ratings),
  L = lists:seq(1, N),
  Left = lists:map(fun(_) -> 1 end, L),
  Right = lists:map(fun(_) -> 1 end, L),

  LeftResult = lists:foldl(fun(I, Acc) ->
    if
      I > 1 andalso lists:nth(I, Ratings) > lists:nth(I - 1, Ratings) ->
        lists:nth(I,Acc) + 1
      else
        lists:nth(I,Acc)
    end
  end, Left, lists:seq(2, N)),

  RightResult = lists:foldr(fun(I, Acc) ->
    if
      I < N andalso lists:nth(I, Ratings) > lists:nth(I + 1, Ratings) ->
        lists:nth(I, Acc) + 1
      else
        lists:nth(I, Acc)
    end
  end, Right, lists:seq(N - 1, -1, 1)),

  Combined = lists:zipwith(fun(LVal, RVal) -> max(LVal, RVal) end, LeftResult, RightResult),

  lists:sum(Combined).