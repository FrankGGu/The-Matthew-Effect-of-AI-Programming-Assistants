-spec memory_leak(integer(), integer()) -> [integer()].
memory_leak(Memory1, Memory2) ->
    memory_leak(Memory1, Memory2, 1).

memory_leak(Memory1, Memory2, Time) when Memory1 >= Time orelse Memory2 >= Time ->
    if
        Memory1 >= Memory2 ->
            memory_leak(Memory1 - Time, Memory2, Time + 1);
        true ->
            memory_leak(Memory1, Memory2 - Time, Time + 1)
    end;
memory_leak(Memory1, Memory2, Time) ->
    [Time, Memory1, Memory2].