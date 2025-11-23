-module(min_rounds).
-export([minimum_rounds/1]).

minimum_rounds(Tasks) ->
    Freq = lists:foldl(fun(Task, Acc) ->
                           maps:update_with(Task, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, Tasks),
    maps:fold(fun(_, Count, Acc) ->
                  case Count of
                      1 -> -1;
                      _ -> Acc + (Count + 2) div 3
                  end
              end, 0, Freq).