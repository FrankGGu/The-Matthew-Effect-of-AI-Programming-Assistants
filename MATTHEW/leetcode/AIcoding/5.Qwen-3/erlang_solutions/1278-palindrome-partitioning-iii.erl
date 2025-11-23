-module(palindrome_partitioning_iii).
-export([partition/1]).

partition(S) ->
    N = erlang:length(S),
    DP = array:new([{size, N}, {default, 0}]),
    DP2 = array:new([{size, N}, {default, 0}]),
    InitDP = init_dp(S, DP, 0),
    InitDP2 = init_dp2(S, DP2, 0),
    solve(S, InitDP, InitDP2, N, 0).

init_dp(_, DP, N) when N >= erlang:length(DP) -> DP;
init_dp(S, DP, I) ->
    Val = cost(S, I, I),
    init_dp(S, array:set(I, Val, DP), I + 1).

init_dp2(_, DP, N) when N >= erlang:length(DP) -> DP;
init_dp2(S, DP, I) ->
    Val = cost(S, I, I),
    init_dp2(S, array:set(I, Val, DP), I + 1).

solve(_, _, _, N, N) -> 0;
solve(S, DP, DP2, N, I) ->
    Min = min_cost(S, DP, DP2, N, I),
    solve(S, DP, DP2, N, I + 1).

min_cost(S, DP, DP2, N, I) ->
    min_cost(S, DP, DP2, N, I, 0, erlang:length(S)).

min_cost(S, DP, DP2, N, I, J, Max) when J >= Max -> infinity;
min_cost(S, DP, DP2, N, I, J, Max) ->
    Cost = array:get(J, DP),
    if
        I == 0 ->
            Cost + min_cost(S, DP, DP2, N, I, J + 1, Max);
        true ->
            Current = array:get(I - 1, DP2) + Cost,
            Next = min_cost(S, DP, DP2, N, I, J + 1, Max),
            erlang:min(Current, Next)
    end.

cost(S, I, J) when I > J -> 0;
cost(S, I, J) ->
    case S of
        [H | T] when I == 0 andalso J == 0 -> 0;
        _ ->
            case erlang:element(I + 1, S) of
                erlang:element(J + 1, S) ->
                    cost(S, I + 1, J - 1);
                _ ->
                    1 + cost(S, I + 1, J - 1)
            end
    end.