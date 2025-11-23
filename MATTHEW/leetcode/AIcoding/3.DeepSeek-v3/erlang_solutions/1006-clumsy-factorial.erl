-spec clumsy(N :: integer()) -> integer().
clumsy(N) ->
    clumsy(N, 1, 0, 0).

clumsy(0, _Sign, Stack, Acc) ->
    Acc + lists:sum(Stack);
clumsy(N, Sign, Stack, Acc) when N >= 4 ->
    case Sign rem 4 of
        1 -> clumsy(N - 1, Sign + 1, [N * (hd(Stack) | tl(Stack))], Acc);
        2 -> clumsy(N - 1, Sign + 1, [hd(Stack) div N | tl(Stack)], Acc);
        3 -> clumsy(N - 1, Sign + 1, Stack, Acc + N);
        0 -> clumsy(N - 1, Sign + 1, [-N], Acc)
    end;
clumsy(N, Sign, Stack, Acc) ->
    case Sign rem 4 of
        1 -> clumsy(0, Sign + 1, [N * (hd(Stack) | tl(Stack))], Acc);
        2 -> clumsy(0, Sign + 1, [hd(Stack) div N | tl(Stack)], Acc);
        3 -> clumsy(0, Sign + 1, Stack, Acc + N);
        0 -> clumsy(0, Sign + 1, [], Acc - N)
    end.