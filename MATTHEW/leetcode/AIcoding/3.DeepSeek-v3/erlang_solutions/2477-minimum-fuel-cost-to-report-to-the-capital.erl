-module(solution).
-export([minimum_fuel_cost/1]).

minimum_fuel_cost(Roads) ->
    N = length(Roads) + 1,
    Adj = lists:foldl(fun([A, B], Acc) ->
                          dict:append(A, B, dict:append(B, A, Acc))
                      end, dict:new(), Roads),
    {_, Ans} = dfs(0, -1, Adj),
    Ans.

dfs(Node, Parent, Adj) ->
    case dict:find(Node, Adj) of
        {ok, Neighbors} ->
            {Total, Fuel} = lists:foldl(fun(Child, {T, F}) ->
                                            case Child of
                                                Parent ->
                                                    {T, F};
                                                _ ->
                                                    {SubT, SubF} = dfs(Child, Node, Adj),
                                                    {T + SubT, F + SubF + (SubT + 4) div 5}
                                            end
                                        end, {1, 0}, Neighbors),
            {Total, Fuel};
        error ->
            {1, 0}
    end.