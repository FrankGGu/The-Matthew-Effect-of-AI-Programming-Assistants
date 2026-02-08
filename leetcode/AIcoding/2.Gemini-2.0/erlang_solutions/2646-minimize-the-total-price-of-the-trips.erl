-module(minimize_the_total_price).
-export([minimum_total_price/2]).

minimum_total_price(N, Edges, Prices, Trips) ->
  Graph = create_graph(N, Edges),
  Counts = calculate_counts(N, Graph, Trips),
  {_, Result} = dp(0, -1, Prices, Counts, Graph),
  Result.

create_graph(N, Edges) ->
  create_graph(N, Edges, array:new(N, {fixed, []})).

create_graph(N, [], Graph) ->
  Graph;
create_graph(N, [[U, V] | Rest], Graph) ->
  Graph1 = array:set(U, [V | array:get(U, Graph)], Graph),
  Graph2 = array:set(V, [U | array:get(V, Graph)], Graph1),
  create_graph(N, Rest, Graph2).

calculate_counts(N, Graph, Trips) ->
  Counts = array:new(N, {fixed, 0}),
  calculate_counts(N, Graph, Trips, Counts).

calculate_counts(N, Graph, [], Counts) ->
  Counts;
calculate_counts(N, Graph, [[Start, End] | Rest], Counts) ->
  Path = find_path(Start, End, Graph, [Start], []),
  Counts1 = update_counts(Path, Counts),
  calculate_counts(N, Graph, Rest, Counts1).

find_path(Start, End, Graph, Path, Visited) ->
  if Start == End ->
    lists:reverse(Path);
  true ->
    Neighbors = array:get(Start, Graph),
    ValidNeighbors = [N || N <- Neighbors, not lists:member(N, Visited)],
    find_path_recursive(End, Graph, Path, [Start | Visited], ValidNeighbors)
  end.

find_path_recursive(End, Graph, Path, Visited, []) ->
  [];
find_path_recursive(End, Graph, Path, Visited, [Neighbor | Rest]) ->
  NewPath = find_path(Neighbor, End, Graph, [Neighbor | Path], Visited),
  if NewPath == [] ->
    find_path_recursive(End, Graph, Path, Visited, Rest);
  true ->
    NewPath
  end.

update_counts([], Counts) ->
  Counts;
update_counts([Node | Rest], Counts) ->
  OldCount = array:get(Node, Counts),
  NewCount = OldCount + 1,
  Counts1 = array:set(Node, NewCount, Counts),
  update_counts(Rest, Counts1).

dp(Node, Parent, Prices, Counts, Graph) ->
  dp(Node, Parent, Prices, Counts, Graph, {}).

dp(Node, Parent, Prices, Counts, Graph, Memo) ->
  Key = {Node, Parent},
  case maps:get(Key, Memo, undefined) of
    undefined ->
      Neighbors = array:get(Node, Graph),
      Children = [N || N <- Neighbors, N /= Parent],
      {Take, Skip} = calculate_values(Node, Children, Prices, Counts, Graph, Memo),
      ResultTake = (Prices ! array:get(Node, Prices)) div 2 * array:get(Node, Counts) + Take,
      ResultSkip = Prices ! array:get(Node, Prices) * array:get(Node, Counts) + Skip,
      MinResult = min(ResultTake, ResultSkip),
      NewMemo = maps:put(Key, {ResultTake,ResultSkip}, Memo),
      {NewMemo, MinResult};
    {Take, Skip} ->
      {Memo, min(Take, Skip)}
  end.

calculate_values(Node, Children, Prices, Counts, Graph, Memo) ->
  calculate_values(Children, Prices, Counts, Graph, Memo, 0, 0).

calculate_values([], Prices, Counts, Graph, Memo, TakeSum, SkipSum) ->
  {TakeSum, SkipSum};
calculate_values([Child | Rest], Prices, Counts, Graph, Memo, TakeSum, SkipSum) ->
  {NewMemo, ChildResult} = dp(Child, Node, Prices, Counts, Graph, Memo),
  {Take, Skip} = ChildResult,
  calculate_values(Rest, Prices, Counts, Graph, NewMemo, TakeSum + Take, SkipSum + Skip).