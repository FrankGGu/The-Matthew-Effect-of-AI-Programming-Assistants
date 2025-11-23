-module(solution).
-export([minimum_cost/2]).

minimum_cost(A, B) ->
    lists:foldl(fun({C1, C2}, Acc) ->
                      case {C1, C2} of
                          {$_, $_} -> Acc;
                          {C1, C2} -> Acc + 1
                      end
                  end, 0, lists:zip(string:to_list(A), string:to_list(B))).