-spec min_steps(N :: integer()) -> integer().
min_steps(1) -> 0;
min_steps(N) ->
    min_steps(N, 2, 0).

min_steps(N, I, Sum) when I * I > N ->
    if
        N =:= 1 -> Sum;
        true -> Sum + N
    end;
min_steps(N, I, Sum) when N rem I =:= 0 ->
    min_steps(N div I, I, Sum + I);
min_steps(N, I, Sum) ->
    min_steps(N, I + 1, Sum).