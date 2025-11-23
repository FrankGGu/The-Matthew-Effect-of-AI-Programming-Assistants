-module(substring_xor_queries).
-export([substring_xor_queries/2]).

substring_xor_queries(S, Queries) ->
  Len = length(S),
  Map = build_map(S),
  lists:map(fun(Query) -> process_query(Query, S, Len, Map) end, Queries).

build_map(S) ->
  Len = length(S),
  build_map_helper(S, 0, Len, #{}).

build_map_helper(_S, Len, Len, Map) ->
  Map;
build_map_helper(S, Start, Len, Map) ->
  build_map_helper2(S, Start, Start, Len, Map).

build_map_helper2(_S, Start, End, Len, Map) when End > Len ->
  build_map_helper(S, Start + 1, Len, Map);
build_map_helper2(S, Start, End, Len, Map) ->
  Sub = string:sub(S, Start + 1, End - Start + 1),
  try
    Num = list_to_integer(string:to_list(Sub)),
    case maps:is_key(Num, Map) of
      true ->
        NewMap = Map;
      false ->
        NewMap = maps:put(Num, {Start, End}, Map)
    end,
    build_map_helper2(S, Start, End + 1, Len, NewMap)
  catch
    _:_ ->
      build_map_helper2(S, Start, End + 1, Len, Map)
  end.

process_query([First, Second], S, Len, Map) ->
  XorResult = First bxor Second,
  case maps:is_key(XorResult, Map) of
    true ->
      {Start, End} = maps:get(XorResult, Map),
      [Start, End];
    false ->
      [-1, -1]
  end.