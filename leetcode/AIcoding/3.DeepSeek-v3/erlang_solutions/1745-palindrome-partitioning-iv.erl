-module(solution).
-export([checkPartitioning/1]).

checkPartitioning(S) ->
    N = length(S),
    DP = lists:duplicate(N, lists:duplicate(N, false)),
    DP1 = init_dp(S, DP, 0, N),
    check_partition(DP1, N).

init_dp(S, DP, I, N) when I < N ->
    DP1 = set_dp(DP, I, I, true),
    DP2 = if I + 1 < N ->
                 case lists:nth(I + 1, S) == lists:nth(I + 1, S) of
                     true -> set_dp(DP1, I, I + 1, true);
                     false -> DP1
                 end;
             true -> DP1
          end,
    init_dp(S, DP2, I + 1, N);
init_dp(_, DP, _, _) -> DP.

set_dp(DP, I, J, Val) ->
    Row = lists:nth(I + 1, DP),
    NewRow = setelement(J + 1, list_to_tuple(Row), Val),
    setelement(I + 1, list_to_tuple(DP), tuple_to_list(NewRow)).

check_partition(DP, N) ->
    lists:any(fun(I) ->
                 lists:any(fun(J) ->
                             get_dp(DP, 0, I - 1) andalso
                             get_dp(DP, I, J - 1) andalso
                             get_dp(DP, J, N - 1)
                          end, lists:seq(I + 1, N - 1))
              end, lists:seq(1, N - 2)).

get_dp(DP, I, J) ->
    Row = lists:nth(I + 1, DP),
    lists:nth(J + 1, Row).