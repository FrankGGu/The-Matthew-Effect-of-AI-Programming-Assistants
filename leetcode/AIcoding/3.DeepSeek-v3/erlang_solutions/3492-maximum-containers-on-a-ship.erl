-module(solution).
-export([maximum_containers/1]).

maximum_containers(S) ->
    {ok, [N, C, M], _} = io_lib:fread("~d~d~d", S),
    maximum_containers(N, C, M, 0).

maximum_containers(N, C, M, Acc) when N >= C ->
    NewContainers = N div C,
    NewAcc = Acc + NewContainers,
    Remaining = N rem C,
    Exchanged = NewContainers,
    maximum_containers(Remaining + Exchanged, C, M, NewAcc);
maximum_containers(_, _, _, Acc) ->
    Acc.