-module(solution).
-export([minOperations/1]).

minOperations(Boxes) ->
    N = length(Boxes),
    lists:map(fun(I) ->
                  calculate_operations_for_box(I, Boxes, N)
              end, lists:seq(0, N - 1)).

calculate_operations_for_box(TargetBoxIndex, Boxes, N) ->
    lists:foldl(fun(CurrentBoxIndex, Acc) ->
                    case lists:nth(CurrentBoxIndex + 1, Boxes) of
                        $1 -> Acc + abs(TargetBoxIndex - CurrentBoxIndex);
                        $0 -> Acc
                    end
                end, 0, lists:seq(0, N - 1)).