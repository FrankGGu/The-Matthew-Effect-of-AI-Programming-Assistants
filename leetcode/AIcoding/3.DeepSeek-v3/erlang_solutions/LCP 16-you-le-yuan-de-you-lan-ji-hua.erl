-module(solution).
-export([max_happiness/1]).

max_happiness(Attractions) ->
    N = length(Attractions),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, -1}])}]),
    {Max, _} = dfs(0, N - 1, Attractions, DP),
    Max.

dfs(I, J, Attractions, DP) ->
    case I > J of
        true -> {0, DP};
        false ->
            case array:get(I, array:get(J, DP)) of
                -1 ->
                    {H1, DP1} = dfs(I + 2, J, Attractions, DP),
                    {H2, DP2} = dfs(I + 1, J - 1, Attractions, DP1),
                    {H3, DP3} = dfs(I, J - 2, Attractions, DP2),
                    H = max(lists:nth(I + 1, Attractions) + min(H1, H2),
                            lists:nth(J + 1, Attractions) + min(H2, H3)),
                    DP4 = array:set(J, array:set(I, H, array:get(J, DP3)), DP3),
                    {H, DP4};
                Val -> {Val, DP}
            end
    end.