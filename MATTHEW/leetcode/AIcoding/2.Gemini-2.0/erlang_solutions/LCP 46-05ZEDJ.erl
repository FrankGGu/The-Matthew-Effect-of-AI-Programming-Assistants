-module(volunteer_allocation).
-export([volunteer_deployment/1]).

volunteer_deployment(plans) ->
  calculate_allocation(plans).

calculate_allocation(Plans) ->
  {Graph, Demand, Supply} = build_graph(Plans),
  {MaxFlow, Flow} = edmonds_karp(Graph, Demand, Supply),
  Flow.

build_graph(Plans) ->
  {Stations, Regions, Volunteers} = parse_plans(Plans),
  NumStations = length(Stations),
  NumRegions = length(Regions),
  NumVolunteers = length(Volunteers),

  Graph = build_base_graph(NumStations, NumRegions, NumVolunteers),

  {GraphWithEdges, Demand, Supply} = add_edges(Graph, Plans, NumStations, NumRegions, NumVolunteers),

  {GraphWithEdges, Demand, Supply}.

parse_plans(Plans) ->
  Stations = lists:usort([Station || {Station, _, _} <- Plans]),
  Regions = lists:usort([Region || {_, Region, _} <- Plans]),
  Volunteers = lists:usort([Volunteer || {_, _, Volunteer} <- Plans]),
  {Stations, Regions, Volunteers}.

build_base_graph(NumStations, NumRegions, NumVolunteers) ->
  Vertices = lists:seq(1, NumStations + NumRegions + NumVolunteers + 2),
  Graph = lists:map(fun(V) -> {V, []} end, Vertices),
  Graph.

add_edges(Graph, Plans, NumStations, NumRegions, NumVolunteers) ->
  Source = NumStations + NumRegions + NumVolunteers + 1,
  Sink = NumStations + NumRegions + NumVolunteers + 2,

  InitialGraph = Graph,
  InitialDemand = lists:duplicate(NumRegions, 0),
  InitialSupply = lists:duplicate(NumStations, 0),

  {FinalGraph, FinalDemand, FinalSupply} = lists:foldl(
    fun({Station, Region, Volunteer}, {AccGraph, AccDemand, AccSupply}) ->
      StationIndex = lists:index(Station, lists:usort([Station1 || {Station1, _, _} <- Plans])),
      RegionIndex = lists:index(Region, lists:usort([Region1 || {_, Region1, _} <- Plans])),
      VolunteerIndex = lists:index(Volunteer, lists:usort([Volunteer1 || {_, _, Volunteer1} <- Plans])),

      StationNode = StationIndex,
      RegionNode = NumStations + RegionIndex,
      VolunteerNode = NumStations + NumRegions + VolunteerIndex,

      {UpdatedGraph1, UpdatedDemand, UpdatedSupply} = add_edge(AccGraph, StationNode, RegionNode, infinity, AccDemand, AccSupply),
      {UpdatedGraph2, UpdatedDemand2, UpdatedSupply2} = add_edge(UpdatedGraph1, RegionNode, VolunteerNode, infinity, UpdatedDemand, UpdatedSupply),

      {UpdatedGraph3, UpdatedDemand3, UpdatedSupply3} = add_supply_edge(UpdatedGraph2, Source, StationNode, 1, UpdatedDemand2, UpdatedSupply2),
      {UpdatedGraph4, UpdatedDemand4, UpdatedSupply4} = add_demand_edge(UpdatedGraph3, VolunteerNode, Sink, 1, UpdatedDemand3, UpdatedSupply3),

      {UpdatedGraph4, UpdatedDemand4, UpdatedSupply4}
    end,
    {InitialGraph, InitialDemand, InitialSupply},
    Plans
  ),

  {FinalGraph, FinalDemand, FinalSupply}.

add_edge(Graph, U, V, Capacity, Demand, Supply) ->
  UpdatedGraph = lists:map(
    fun({Node, Neighbors}) ->
      case Node of
        U -> {Node, [{V, Capacity} | Neighbors]};
        _ -> {Node, Neighbors}
      end
    end,
    Graph
  ),
  {UpdatedGraph, Demand, Supply}.

add_supply_edge(Graph, Source, StationNode, Capacity, Demand, Supply) ->
    UpdatedGraph = lists:map(
    fun({Node, Neighbors}) ->
      case Node of
        Source -> {Node, [{StationNode, Capacity} | Neighbors]};
        _ -> {Node, Neighbors}
      end
    end,
    Graph
  ),
  {UpdatedGraph, Demand, Supply}.

add_demand_edge(Graph, VolunteerNode, Sink, Capacity, Demand, Supply) ->
  UpdatedGraph = lists:map(
    fun({Node, Neighbors}) ->
      case Node of
        VolunteerNode -> {Node, [{Sink, Capacity} | Neighbors]};
        _ -> {Node, Neighbors}
      end
    end,
    Graph
  ),
  {UpdatedGraph, Demand, Supply}.

edmonds_karp(Graph, Demand, Supply) ->
  Source = length(Graph) - 1,
  Sink = length(Graph),
  {MaxFlow, Flow} = edmonds_karp_helper(Graph, Source, Sink, []),
  {MaxFlow, Flow}.

edmonds_karp_helper(Graph, Source, Sink, Flow) ->
  Path = bfs(Graph, Source, Sink, []),
  case Path of
    no_path ->
      {calculate_flow(Flow), Flow};
    _ ->
      AugmentAmount = find_augment_amount(Graph, Path),
      UpdatedGraph = augment_flow(Graph, Path, AugmentAmount),
      UpdatedFlow = add_flow(Flow, Path, AugmentAmount),
      edmonds_karp_helper(UpdatedGraph, Source, Sink, UpdatedFlow)
  end.

bfs(Graph, Source, Sink, Visited) ->
  bfs_helper([Source], Graph, Sink, Visited, []).

bfs_helper([], _Graph, _Sink, _Visited, _Path) ->
  no_path;
bfs_helper(Queue, Graph, Sink, Visited, Path) ->
  case Queue of
    [] ->
      no_path;
    [U | Rest] ->
      case lists:member(U, Visited) of
        true ->
          bfs_helper(Rest, Graph, Sink, Visited, Path);
        false ->
          Neighbors = get_neighbors(Graph, U),
          UnvisitedNeighbors = [V || {V, Capacity} <- Neighbors, Capacity > 0, not lists:member(V, Visited)],
          NewQueue = Rest ++ UnvisitedNeighbors,
          case lists:member(Sink, UnvisitedNeighbors) of
            true ->
              PathSoFar = lists:reverse([find_path(Sink, Graph, U, Visited)]),
              [Source | PathSoFar];
            false ->
              bfs_helper(NewQueue, Graph, Sink, [U | Visited], Path)
          end
      end
  end.

find_path(V, Graph, U, Visited) ->
    U.

get_neighbors(Graph, Node) ->
  case lists:keyfind(Node, 1, Graph) of
    {_, Neighbors} ->
      Neighbors;
    false ->
      []
  end.

find_augment_amount(Graph, Path) ->
  find_augment_amount_helper(Graph, Path, infinity).

find_augment_amount_helper(_Graph, [_], MinCapacity) ->
  MinCapacity;
find_augment_amount_helper(Graph, [U, V | Rest], MinCapacity) ->
  Capacity = get_capacity(Graph, U, V),
  NewMinCapacity = min(MinCapacity, Capacity),
  find_augment_amount_helper(Graph, [V | Rest], NewMinCapacity).

get_capacity(Graph, U, V) ->
  case lists:keyfind(U, 1, Graph) of
    {_, Neighbors} ->
      case lists:keyfind(V, 1, Neighbors) of
        {_, Capacity} ->
          Capacity;
        false ->
          0
      end;
    false ->
      0
  end.

augment_flow(Graph, Path, AugmentAmount) ->
  augment_flow_helper(Graph, Path, AugmentAmount).

augment_flow_helper(Graph, [_], _AugmentAmount) ->
  Graph;
augment_flow_helper(Graph, [U, V | Rest], AugmentAmount) ->
  UpdatedGraph = update_edge(Graph, U, V, AugmentAmount),
  augment_flow_helper(UpdatedGraph, [V | Rest], AugmentAmount).

update_edge(Graph, U, V, AugmentAmount) ->
  UpdatedGraph1 = update_capacity(Graph, U, V, -AugmentAmount),
  UpdatedGraph2 = update_capacity(UpdatedGraph1, V, U, AugmentAmount),