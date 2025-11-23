-module(closest_nodes).
-export([closest_nodes/2]).

closest_nodes(Root, Queries) ->
  Values = inorder(Root, []),
  lists:map(fun(Query) -> find_closest(Query, Values) end, Queries).

inorder(null, Acc) ->
  lists:reverse(Acc);
inorder(#{val := Val, left := Left, right := Right}, Acc) ->
  inorder(Left, [Val | inorder(Right, Acc)]).

find_closest(Query, Values) ->
  Lower = find_lower(Query, Values, -1),
  Upper = find_upper(Query, Values, -1),
  [Lower, Upper].

find_lower(Query, Values, Default) ->
  find_lower(Query, Values, 0, length(Values) - 1, Default).

find_lower(_Query, [], _Low, _High, Default) ->
  Default;
find_lower(Query, Values, Low, High, Default) when Low > High ->
  Default;
find_lower(Query, Values, Low, High, Default) ->
  Mid = (Low + High) div 2,
  case lists:nth(Mid + 1, Values) of
    Val when Val =< Query ->
      find_lower(Query, Values, Mid + 1, High, Val);
    _ ->
      find_lower(Query, Values, Low, Mid - 1, Default)
  end.

find_upper(Query, Values, Default) ->
  find_upper(Query, Values, 0, length(Values) - 1, Default).

find_upper(_Query, [], _Low, _High, Default) ->
  Default;
find_upper(Query, Values, Low, High, Default) when Low > High ->
  Default;
find_upper(Query, Values, Low, High, Default) ->
  Mid = (Low + High) div 2,
  case lists:nth(Mid + 1, Values) of
    Val when Val >= Query ->
      find_upper(Query, Values, Low, Mid - 1, Val);
    _ ->
      find_upper(Query, Values, Mid + 1, High, Default)
  end.