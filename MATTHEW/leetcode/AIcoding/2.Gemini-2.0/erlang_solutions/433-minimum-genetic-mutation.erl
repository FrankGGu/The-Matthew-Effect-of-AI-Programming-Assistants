-module(minimum_mutation).
-export([min_mutation/3]).

min_mutation(Start, End, Bank) ->
  min_mutation(Start, End, Bank, [], 0).

min_mutation(Start, End, Bank, Visited, Count) ->
  if Start == End ->
    Count;
  true ->
    Neighbors = find_neighbors(Start, Bank, Visited),
    if Neighbors == [] ->
      -1;
    true ->
      MinCounts = [
        case min_mutation(Neighbor, End, Bank, [Start | Visited], Count + 1) of
          -1 -> infinity;
          Result -> Result
        end
       || Neighbor <- Neighbors
      ],
      Min = lists:min(MinCounts),
      if Min == infinity ->
        -1;
      true ->
        Min
      end
    end
  end.

find_neighbors(Gene, Bank, Visited) ->
  [Neighbor || Neighbor <- Bank,
                not lists:member(Neighbor, Visited),
                is_neighbor(Gene, Neighbor)].

is_neighbor(Gene1, Gene2) ->
  Diff = lists:zipwith(fun(X, Y) -> if X == Y -> 0; true -> 1 end, string:to_list(Gene1), string:to_list(Gene2)),
  Sum = lists:sum(Diff),
  Sum == 1.