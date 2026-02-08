-module(equal_occurrences).
-export([solve/1]).

solve(S) ->
    Counts = lists:foldl(fun(C, Acc) ->
                                  case maps:is_key(C, Acc) of
                                      true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
                                      false -> maps:put(C, 1, Acc)
                                  end
                          end, #{}, S),
    Values = maps:values(Counts),
    lists:all(fun(X) -> X == lists:nth(1, Values) end, Values).