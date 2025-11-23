-module(jump_game_iv).
-export([min_jumps/1]).

min_jumps(Arr) ->
  Len = length(Arr),
  if Len =< 1 then
    0
  else
    ValueMap = build_value_map(Arr),
    bfs(Arr, ValueMap, [0], #{0 => 0}, Len)
  end.

build_value_map(Arr) ->
  lists:foldl(
    fun(
      {Index, Value}, Acc
    ) ->
      case maps:is_key(Value, Acc) of
        true ->
          maps:update(Value, [Index | maps:get(Value, Acc)], Acc);
        false ->
          maps:put(Value, [Index], Acc)
      end
    end,
    #{},
    lists:zip(lists:seq(0, length(Arr) - 1), Arr)
  ).

bfs(Arr, ValueMap, Queue, Visited, Len) ->
  case Queue of
    [] ->
      infinity;
    [H | T] ->
      if H =:= Len - 1 then
        maps:get(H, Visited)
      else
        Dist = maps:get(H, Visited),
        NextNodes = get_next_nodes(Arr, ValueMap, H, Len),
        {NewQueue, NewVisited} = lists:foldl(
          fun(Node, {QAcc, VAcc}) ->
            case maps:is_key(Node, VAcc) of
              true ->
                {QAcc, VAcc};
              false ->
                {[Node | QAcc], maps:put(Node, Dist + 1, VAcc)}
            end
          end,
          {T, Visited},
          NextNodes
        ),
        bfs(Arr, ValueMap, lists:reverse(NewQueue), NewVisited, Len)
      end
  end.

get_next_nodes(Arr, ValueMap, Index, Len) ->
  Value = lists:nth(Index + 1, Arr),
  SameValueIndices = maps:get(Value, ValueMap),
  maps:remove(Value, ValueMap),
  ValidIndices = lists:filter(
    fun(I) ->
      I >= 0 andalso I < Len andalso I /= Index
    end,
    [Index - 1, Index + 1] ++ SameValueIndices
  ).

infinity ->
  infinity.