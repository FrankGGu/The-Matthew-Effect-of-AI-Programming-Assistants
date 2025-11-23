-module(closest_equal_element_queries).
-export([closest_equal_element_queries/2]).

closest_equal_element_queries(Arr, Queries) ->
  Map = build_index_map(Arr),
  lists:map(fun(Query) -> process_query(Query, Map) end, Queries).

build_index_map(Arr) ->
  lists:foldl(fun({Elem, Index}, Acc) ->
                  case maps:is_key(Elem, Acc) of
                    true ->
                      maps:update(Elem, [Index | maps:get(Elem, Acc)], Acc);
                    false ->
                      maps:put(Elem, [Index], Acc)
                  end
              end, #{}, lists:zip(Arr, lists:seq(1, length(Arr)))).

process_query([Left, Right, Value], Map) ->
  case maps:is_key(Value, Map) of
    true ->
      Indices = maps:get(Value, Map),
      find_closest(Left, Right, Indices);
    false ->
      -1
  end.

find_closest(Left, Right, Indices) ->
  lists:foldl(fun(Index, Acc) ->
                  case (Index >= Left) and (Index <= Right) of
                    true ->
                      case Acc of
                        -1 ->
                          Index;
                        _ ->
                          Acc
                      end;
                    false ->
                      Acc
                  end
              end, -1, Indices).