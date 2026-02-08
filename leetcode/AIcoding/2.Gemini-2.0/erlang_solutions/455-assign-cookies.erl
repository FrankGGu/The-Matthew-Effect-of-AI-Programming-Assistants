-module(assign_cookies).
-export([find_content_children/2]).

find_content_children(G, S) ->
  find_content_children(lists:sort(G), lists:sort(S), 0).

find_content_children([], _, Acc) ->
  Acc;
find_content_children(_, [], Acc) ->
  Acc;
find_content_children([G | GTail], [S | STail], Acc) ->
  if
    S >= G ->
      find_content_children(GTail, STail, Acc + 1);
    true ->
      find_content_children([G | GTail], STail, Acc)
  end.