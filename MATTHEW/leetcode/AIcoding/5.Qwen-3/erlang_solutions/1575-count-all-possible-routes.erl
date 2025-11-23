-module(solution).
-export([count_routes/2]).

count_routes(roads, start) ->
    count_routes(roads, start, 0, dict:new()).

count_routes(_, _, _, _) when start < 0 orelse start >= length(roads) -> 0;
count_routes(roads, start, fuel, Memo) ->
    Key = {start, fuel},
    case dict:is_key(Key, Memo) of
        true -> dict:fetch(Key, Memo);
        false ->
            Total = if
                        fuel == 0 -> 1;
                        true -> 0
                    end,
            NewTotal = lists:foldl(fun (i, Acc) ->
                                          if
                                              i == start -> Acc;
                                              true ->
                                                  Cost = lists:nth(i + 1, roads),
                                                  if
                                                      Cost =< fuel ->
                                                          NewFuel = fuel - Cost,
                                                          Acc + count_routes(roads, i, NewFuel, Memo);
                                                      true -> Acc
                                                  end
                                          end
                                      end, Total, lists:seq(0, length(roads) - 1)),
            NewMemo = dict:store(Key, NewTotal, Memo),
            NewTotal.
end.