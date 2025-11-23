-module(minimum_fuel_cost).
-export([minimum_fuel_cost/2]).

minimum_fuel_cost(N, Roads) ->
  graph_to_adj_list(N, Roads, AdjList),
  minimum_fuel_cost_helper(0, N, AdjList).

minimum_fuel_cost_helper(Seats, N, AdjList) ->
  {_, Fuel} = dfs(0, -1, N, Seats, AdjList),
  Fuel.

dfs(Node, Parent, N, Seats, AdjList) ->
  People = 1,
  Fuel = 0,
  for(Neighbor <- maps:get(Node, AdjList, []),
    Neighbor /= Parent,
    begin
      {P, F} = dfs(Neighbor, Node, N, Seats, AdjList),
      People1 = People + P,
      Fuel1 = Fuel + F + (P + Seats - 1) div Seats,
      {People1, Fuel1}
    end,
    {People, Fuel}).

graph_to_adj_list(N, Roads, AdjList) ->
  lists:foldl(
    fun([U, V], Acc) ->
      Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
      maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
    end,
    maps:from_list([{I, []} || I <- lists:seq(0, N - 1)]),
    Roads
  ).