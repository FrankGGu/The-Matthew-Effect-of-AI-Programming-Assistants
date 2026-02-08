-module(solution).
-export([is_covered/3]).

is_covered(Ranges, Left, Right) ->
  is_covered(Ranges, Left, Right, []).

is_covered([], Left, Right, Covered) ->
  lists:all(fun(X) -> lists:member(X, Covered) end, lists:seq(Left, Right));

is_covered([Range | Rest], Left, Right, Covered) ->
  [Start, End] = Range,
  NewCovered = lists:foldl(fun(X, Acc) ->
                                  case lists:member(X, Acc) of
                                    true -> Acc;
                                    false -> [X | Acc]
                                  end
                              end, Covered, lists:seq(Start, End)),
  is_covered(Rest, Left, Right, NewCovered).