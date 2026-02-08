-module(min_operations).
-export([min_operations/2]).

min_operations(nums, target) ->
  min_operations(nums, target, 0).

min_operations([], 0, Acc) ->
  Acc;
min_operations([], Target, _) when Target > 0 ->
  -1;
min_operations([H|T], Target, Acc) when Target < 0 ->
  -1;
min_operations([H|T], Target, Acc) ->
  case H =< Target of
    true ->
      min(min_operations(T, Target - H, Acc),
          case H > 1 andalso H band 1 == 0 of
            true ->
              case min_operations(T, Target, Acc + 1) of
                -1 ->
                  infinity;
                M ->
                  M + 1
              end;
            false ->
              infinity
          end
         );
    false ->
      case H > 1 andalso H band 1 == 0 of
        true ->
          case min_operations(T, Target, Acc + 1) of
            -1 ->
              min_operations(T, Target, Acc + 1);
            M ->
              min_operations(T, Target, Acc + 1)
          end;
        false ->
          min_operations(T, Target, Acc)
      end
  end.

min(A, B) when A < 0 -> B;
min(A, B) when B < 0 -> A;
min(A, B) -> erlang:min(A, B).

infinity() -> 1000000000.