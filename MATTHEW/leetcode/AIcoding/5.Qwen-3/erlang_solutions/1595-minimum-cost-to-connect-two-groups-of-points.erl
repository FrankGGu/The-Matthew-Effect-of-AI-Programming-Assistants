-module(minimum_cost_to_connect_two_groups_of_points).
-export([connectTwoGroups/1]).

connectTwoGroups(Cost) ->
    N = length(Cost),
    M = length(hd(Cost)),
    DP = array:new(N * M, {default, 0}),
    connectTwoGroups(Cost, N, M, DP, 0, 0).

connectTwoGroups(_, _, _, DP, I, J) when I == 0 andalso J == 0 ->
    array:get(0, DP);
connectTwoGroups(Cost, N, M, DP, I, J) ->
    case I < N of
        true ->
            case J < M of
                true ->
                    CostIJ = lists:nth(I + 1, Cost),
                    CostIJJ = lists:nth(J + 1, CostIJ),
                    NewDP = array:set(I * M + J, CostIJJ, DP),
                    connectTwoGroups(Cost, N, M, NewDP, I, J + 1);
                false ->
                    connectTwoGroups(Cost, N, M, DP, I + 1, 0)
            end;
        false ->
            case J < M of
                true ->
                    connectTwoGroups(Cost, N, M, DP, I, J + 1);
                false ->
                    0
            end
    end.