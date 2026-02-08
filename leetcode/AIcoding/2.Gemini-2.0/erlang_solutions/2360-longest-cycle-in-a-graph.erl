-module(longest_cycle).
-export([longestCycle/1]).

longestCycle(Edges) ->
  N = length(Edges),
  longestCycleHelper(Edges, N).

longestCycleHelper(Edges, N) ->
  Visited = array:new([N], {false}),
  Path = array:new([N], {0}),
  MaxCycle = -1,
  lists:foldl(fun(I, Acc) ->
                  case array:get(I, Visited) of
                    false ->
                      explore(I, Edges, Visited, Path, 1, Acc);
                    true ->
                      Acc
                  end
              end, -1, lists:seq(0, N - 1)).

explore(Node, Edges, Visited, Path, PathLen, MaxCycle) ->
  array:set(Node, Visited, true),
  array:set(Node, Path, PathLen),
  Next = lists:nth(Node + 1, Edges),
  case Next of
    -1 ->
      array:set(Node, Path, 0),
      MaxCycle;
    _ ->
      case array:get(Next, Visited) of
        false ->
          explore(Next, Edges, Visited, Path, PathLen + 1, MaxCycle);
        true ->
          case array:get(Next, Path) of
            0 ->
              MaxCycle;
            PrevPathLen ->
              CycleLen = PathLen - PrevPathLen + 1,
              array:set(Node, Path, 0),
              max(MaxCycle, CycleLen)
          end
      end
  end.