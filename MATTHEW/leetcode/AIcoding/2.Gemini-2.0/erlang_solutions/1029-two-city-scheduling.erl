-module(two_city_scheduling).
-export([minCost/1]).

minCost(Costs) ->
    N = length(Costs) div 2,
    SortedCosts = lists:keysort(1, [{abs(A - B), A, B} || {A, B} <- Costs]),
    {Cost, _, _} = lists:foldl(
        fun({_, A, B}, {AccCost, CountA, CountB}) ->
            if CountA < N andalso CountB < N then
                if A < B then
                    {AccCost + A, CountA + 1, CountB}
                else
                    {AccCost + B, CountA, CountB + 1}
                end
            else if CountA < N then
                {AccCost + A, CountA + 1, CountB}
            else
                {AccCost + B, CountA, CountB + 1}
            end
        end,
        {0, 0, 0},
        SortedCosts
    ),
    Cost.