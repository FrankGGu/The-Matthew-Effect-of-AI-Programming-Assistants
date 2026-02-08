-module(delivery_boxes).
-export([box_deliveries/3]).

box_deliveries(Boxes, PortsCount, MaxBoxes) ->
    N = length(Boxes),
    {_Cost, Result} = solve(Boxes, PortsCount, MaxBoxes, N),
    Result.

solve(Boxes, PortsCount, MaxBoxes, N) ->
    Cache = dict:new(),
    solve_memo(0, Boxes, PortsCount, MaxBoxes, N, Cache).

solve_memo(I, Boxes, PortsCount, MaxBoxes, N, Cache) ->
    case dict:find(I, Cache) of
        {ok, Value} ->
            Value;
        error ->
            Result = solve_recursive(I, Boxes, PortsCount, MaxBoxes, N, Cache),
            dict:store(I, Result, Cache),
            Result
    end.

solve_recursive(N, _Boxes, _PortsCount, _MaxBoxes, _N, _Cache) ->
    {0, 0};
solve_recursive(I, Boxes, PortsCount, MaxBoxes, N, Cache) ->
    MinCost = lists:foldl(
        fun(J, {AccCost, AccResult}) ->
            if I + J > N then
                {AccCost, AccResult}
            else
                SubList = lists:sublist(Boxes, I + 1, J),
                {Cost, Change} = calculate_cost(SubList, PortsCount),
                {SubCost, SubResult} = solve_memo(I + J, Boxes, PortsCount, MaxBoxes, N, Cache),
                if J =< MaxBoxes then
                    NewCost = Cost + SubCost,
                    NewResult = Change + SubResult + 1,
                    if NewCost < AccCost then
                        {NewCost, NewResult}
                    else
                        {AccCost, AccResult}
                    else
                        {AccCost, AccResult}
                    end
            end
        end,
        {infinity, infinity},
        lists:seq(1, N - I)
    ),
    MinCost.

calculate_cost(Boxes, _PortsCount) ->
    calculate_cost_helper(Boxes, 0, 0, -1).

calculate_cost_helper([], Cost, Changes, _) ->
    {Cost, Changes};
calculate_cost_helper([[Port, _] | Rest], Cost, Changes, PrevPort) ->
    NewChanges = if Port /= PrevPort andalso PrevPort /= -1 then Changes + 1 else Changes end,
    calculate_cost_helper(Rest, Cost + 1, NewChanges, Port).
calculate_cost_helper([[Port] | Rest], Cost, Changes, PrevPort) ->
    NewChanges = if Port /= PrevPort andalso PrevPort /= -1 then Changes + 1 else Changes end,
    calculate_cost_helper(Rest, Cost + 1, NewChanges, Port).