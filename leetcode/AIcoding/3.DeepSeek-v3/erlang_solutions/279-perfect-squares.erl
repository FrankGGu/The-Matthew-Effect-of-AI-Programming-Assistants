-module(solution).
-export([num_squares/1]).

num_squares(N) ->
    DP = array:new(N + 1, [{default, N + 1}]),
    DP1 = array:set(0, 0, DP),
    num_squares(1, N, DP1).

num_squares(I, N, DP) when I > N ->
    array:get(N, DP);
num_squares(I, N, DP) ->
    J = 1,
    DP2 = loop_j(I, J, DP),
    num_squares(I + 1, N, DP2).

loop_j(I, J, DP) ->
    case J * J > I of
        true -> DP;
        false ->
            Val = array:get(I - J * J, DP) + 1,
            Current = array:get(I, DP),
            if
                Val < Current ->
                    NewDP = array:set(I, Val, DP),
                    loop_j(I, J + 1, NewDP);
                true ->
                    loop_j(I, J + 1, DP)
            end
    end.