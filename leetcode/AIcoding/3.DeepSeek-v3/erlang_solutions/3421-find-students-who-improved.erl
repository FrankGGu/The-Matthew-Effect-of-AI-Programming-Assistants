-module(solution).
-export([improved_students/1]).

improved_students(Scores) ->
    Grouped = lists:foldl(fun([Id, Year, Score], Acc) ->
                                  case maps:find(Id, Acc) of
                                      {ok, [{Y1, S1}]} when Year =/= Y1 ->
                                          case {Year, Y1} of
                                              {2, 1} when Score > S1 -> maps:put(Id, improved, Acc);
                                              {1, 2} when Score > S1 -> maps:put(Id, improved, Acc);
                                              _ -> maps:put(Id, not_improved, Acc)
                                          end;
                                      _ ->
                                          maps:put(Id, [{Year, Score}], Acc)
                                  end
                          end, maps:new(), Scores),
    Improved = maps:fold(fun(Id, Status, Acc) ->
                                 case Status of
                                     improved -> [Id | Acc];
                                     _ -> Acc
                                 end
                         end, [], Grouped),
    lists:sort(Improved).