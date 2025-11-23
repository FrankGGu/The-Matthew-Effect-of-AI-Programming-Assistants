-module(longest_special_path_ii).
-export([longest_path/2]).

longest_path(N, Edges) ->
  Graph = build_graph(N, Edges),
  memo = dict:new(),
  lists:max([dfs(Node, Graph, memo, []) || Node <- lists:seq(1, N)]).

build_graph(N, Edges) ->
  lists:foldl(fun({U, V, W}, Acc) ->
                  case dict:find(U, Acc) of
                    {ok, Neighbors} ->
                      dict:update(U, [{V, W} | Neighbors], Acc);
                    error ->
                      dict:store(U, [{V, W}], Acc)
                  end
              end, dict:new(), Edges).

dfs(Node, Graph, Memo, Path) ->
  case lists:member(Node, Path) of
    true ->
      0;
    false ->
      case dict:find(Node, Memo) of
        {ok, Len} ->
          Len;
        error ->
          case dict:find(Node, Graph) of
            {ok, Neighbors} ->
              MaxLen = lists:max([W + dfs(Neighbor, Graph, Memo, [Node | Path]) || {Neighbor, W} <- Neighbors]);
              dict:store(Node, MaxLen, Memo),
              MaxLen;
            error ->
              dict:store(Node, 0, Memo),
              0
          end
      end
  end.