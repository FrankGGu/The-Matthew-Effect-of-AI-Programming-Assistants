-module(find_all_people_with_secret).
-export([solve/2]).

solve(n, meetings) ->
  solve(n, meetings, [0]).

solve(n, Meetings, InitialKnowledge) ->
  solve(n, Meetings, InitialKnowledge, 0).

solve(n, Meetings, Known, Time) ->
  FilteredMeetings = lists:filter(fun({_, T, _}) -> T =:= Time end, Meetings),
  case FilteredMeetings of
    [] ->
      NextTime = lists:foldl(fun({_, T, _}, Acc) -> min(Acc,T) end, infinity, lists:filter(fun({_, T, _}) -> T > Time end, Meetings)),
      case NextTime of
        infinity ->
          lists:sort(Known);
        _ ->
          solve(n, Meetings, Known, NextTime)
      end;
    _ ->
      Graph = build_graph(FilteredMeetings),
      NewKnown = propagate_knowledge(Graph, Known),
      RemainingMeetings = lists:filter(fun({_, T, _}) -> T > Time end, Meetings),
      solve(n, RemainingMeetings, lists:sort(lists:usort(Known ++ NewKnown)), Time + 1)
  end.

build_graph(Meetings) ->
  lists:foldl(fun({P1, _, P2}, Acc) ->
                Acc#{P1 => lists:usort(lists:append(maps:get(P1, Acc, []), [P2])),
                      P2 => lists:usort(lists:append(maps:get(P2, Acc, []), [P1]))}
              end, #{}, Meetings).

propagate_knowledge(Graph, Known) ->
  propagate_knowledge(Graph, Known, Known).

propagate_knowledge(_, [], Acc) ->
  Acc;
propagate_knowledge(Graph, [P | Rest], Acc) ->
  Neighbors = maps:get(P, Graph, []),
  NewKnown = lists:filter(fun(N) -> not lists:member(N, Acc) end, Neighbors),
  propagate_knowledge(Graph, Rest ++ NewKnown, lists:usort(Acc ++ NewKnown)).