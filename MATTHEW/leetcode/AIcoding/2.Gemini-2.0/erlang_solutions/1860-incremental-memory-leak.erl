-module(incremental_memory_leak).
-export([incremental_memory_leak/1]).

incremental_memory_leak(Memory1, Memory2) ->
  incremental_memory_leak(Memory1, Memory2, 1).

incremental_memory_leak(Memory1, Memory2, Cycle) ->
  case Memory1 >= Memory2 of
    true ->
      case Memory1 >= Cycle of
        true ->
          incremental_memory_leak(Memory1 - Cycle, Memory2, Cycle + 1);
        false ->
          [Cycle, Memory1, Memory2]
      end;
    false ->
      case Memory2 >= Cycle of
        true ->
          incremental_memory_leak(Memory1, Memory2 - Cycle, Cycle + 1);
        false ->
          [Cycle, Memory1, Memory2]
      end
  end.