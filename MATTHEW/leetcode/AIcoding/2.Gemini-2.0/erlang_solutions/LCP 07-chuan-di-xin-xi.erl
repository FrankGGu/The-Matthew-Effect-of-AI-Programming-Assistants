-module(solution).
-export([num_ways/3]).

num_ways(N, Relations, K) ->
  Graph = lists:foldl(
    fun([U, V], Acc) ->
      case maps:is_key(U, Acc) of
        true -> maps:update(U, Acc[U] ++ [V], Acc);
        false -> maps:put(U, [V], Acc)
      end
    end,
    #{},
    Relations
  ),

  num_ways_helper(0, N, Graph, K).

num_ways_helper(Current, N, Graph, K) ->
  num_ways_helper(Current, N, Graph, K, [0], 0).

num_ways_helper(_, _, _, 0, [N - 1 | _], Count) ->
  Count + 1;
num_ways_helper(_, _, _, 0, _, Count) ->
  Count;
num_ways_helper(N, _, Graph, K, Path, Count) ->
  case maps:is_key(N, Graph) of
    true ->
      NextNodes = Graph[N],
      lists:foldl(
        fun(NextNode, Acc) ->
          num_ways_helper(NextNode, _, Graph, K - 1, [NextNode | Path], Acc)
        end,
        Count,
        NextNodes
      );
    false ->
      Count
  end.