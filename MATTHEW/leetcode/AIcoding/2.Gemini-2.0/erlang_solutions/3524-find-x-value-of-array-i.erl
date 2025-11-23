-module(solution).
-export([final_value_after_operations/1]).

final_value_after_operations(Operations) ->
  lists:foldl(fun(Op, Acc) ->
                  case Op of
                    "++X" -> Acc + 1;
                    "X++" -> Acc + 1;
                    "--X" -> Acc - 1;
                    "X--" -> Acc - 1
                  end
                end, 0, Operations).