-module(binary_trees_with_factors).
-export([numTrees/1]).

numTrees(Arr) ->
  Mod = 1000000007,
  SortedArr = lists:sort(Arr),
  Map = dict:from_list([{X, 1} || X <- SortedArr]),
  numTreesHelper(SortedArr, Map, Mod).

numTreesHelper([], Map, _) ->
  dict:fold(fun(_, Count, Acc) -> (Acc + Count) rem Mod end, 0, Map);
numTreesHelper([H | T], Map, Mod) ->
  NewMap = lists:foldl(fun(X, AccMap) ->
                         if H rem X == 0 ->
                           Y = H div X,
                           case dict:find(Y, AccMap) of
                             {ok, YCount} ->
                               XCount = dict:fetch(X, AccMap),
                               CurrentCount = dict:fetch(H, AccMap),
                               NewCount = (CurrentCount + (XCount * YCount)) rem Mod,
                               NewCount2 = (NewCount + (X =/= Y) * (XCount * YCount)) rem Mod,
                               dict:update(H, NewCount2, AccMap);
                             _ ->
                               AccMap
                           end;
                         true ->
                           AccMap
                         end
                       end, Map, lists:sort(lists:filter(fun(X) -> X < H end, dict:keys(Map)))),
  numTreesHelper(T, NewMap, Mod).