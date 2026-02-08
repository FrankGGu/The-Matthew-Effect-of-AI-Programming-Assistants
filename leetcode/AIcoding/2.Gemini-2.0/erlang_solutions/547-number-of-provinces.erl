-module(number_of_provinces).
-export([num_provinces/1]).

num_provinces(isConnected) ->
  N = length(isConnected),
  DSU = dsu:new(N),
  lists:foreach(
    fun(I) ->
      lists:foreach(
        fun(J) ->
          if J > I andalso lists:nth(J, lists:nth(I, isConnected)) == 1 ->
            dsu:union(DSU, I, J)
          else
            ok
          end
        end,
        lists:seq(1, N)
      )
    end,
    lists:seq(1, N)
  ),
  dsu:count_sets(DSU).

-module(dsu).
-export([new/1, find/2, union/3, count_sets/1]).

new(N) ->
  {array:new(N, {value, 0}), array:new(N, {parent, lists:seq(1, N)}), N}.

find({_, Parents, _}, X) ->
  case array:get({parent, X}, Parents) of
    X ->
      X;
    Parent ->
      Root = find({_, Parents, _}, Parent),
      array:set({parent, X}, Root, Parents),
      Root
  end.

union({Values, Parents, Sets}, X, Y) ->
  RootX = find({Values, Parents, Sets}, X),
  RootY = find({Values, Parents, Sets}, Y),
  if RootX == RootY then
    {Values, Parents, Sets}
  else
    array:set({parent, RootX}, RootY, Parents),
    {Values, Parents, Sets - 1}
  end.

count_sets({_, _, Sets}) ->
  Sets.