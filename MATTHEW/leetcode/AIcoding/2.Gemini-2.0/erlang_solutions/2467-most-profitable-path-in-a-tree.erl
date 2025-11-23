-module(most_profitable_path).
-export([most_profitable_path/2]).

most_profitable_path(Edges, Amount) ->
    N = length(Amount),
    Graph = lists:foldl(
        fun([U, V], Acc) ->
            Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                  V => lists:append(maps:get(V, Acc, []), [U])}
        end, #{}, Edges),

    {AlicePath, BobTime} = find_alice_path(Graph, N),

    MaxProfit = calculate_max_profit(Graph, 0, -1, AlicePath, BobTime, Amount),
    MaxProfit.

find_alice_path(Graph, N) ->
    {Path, _} = find_path(Graph, 0, -1, [0], N),
    BobTimes = calculate_bob_times(Graph, N),
    {Path, BobTimes}.

find_path(Graph, Node, Parent, CurrentPath, N) ->
    if Node == N - 1 then
        {lists:reverse(CurrentPath), true}
    else
        Neighbors = maps:get(Node, Graph, []),
        FilteredNeighbors = lists:filter(fun(Neighbor) -> Neighbor /= Parent end, Neighbors),
        case FilteredNeighbors of
            [] -> {[], false};
            [Neighbor | Rest] ->
                case find_path(Graph, Neighbor, Node, [Neighbor | CurrentPath], N) of
                    {Path, true} -> {Path, true};
                    {_, false} ->
                        find_path(Graph, lists:nth(1, Rest), Node, [lists:nth(1, Rest) | CurrentPath], N)
                end
        end
    end.

calculate_bob_times(Graph, N) ->
    calculate_bob_times_helper(Graph, N - 1, -1, 0, #{N - 1 => 0}).

calculate_bob_times_helper(Graph, Node, Parent, Time, Acc) ->
    Neighbors = maps:get(Node, Graph, []),
    FilteredNeighbors = lists:filter(fun(Neighbor) -> Neighbor /= Parent end, Neighbors),
    case FilteredNeighbors of
        [] -> Acc;
        [Neighbor | Rest] ->
            NewAcc1 = calculate_bob_times_helper(Graph, Neighbor, Node, Time + 1, Acc#{Neighbor => Time + 1}),
            calculate_bob_times_helper(Graph, lists:nth(1,Rest), Node, Time + 1, NewAcc1)
    end.

calculate_max_profit(Graph, Node, Parent, AlicePath, BobTimes, Amount) ->
    Profit =
        case lists:member(Node, AlicePath) of
            true ->
                case maps:is_key(Node, BobTimes) andalso maps:get(Node, BobTimes) == lists:index(AlicePath, Node) - 1 of
                    true -> Amount !! Node div 2;
                    false -> Amount !! Node
                end;
            false -> Amount !! Node
        end,

    Neighbors = maps:get(Node, Graph, []),
    FilteredNeighbors = lists:filter(fun(Neighbor) -> Neighbor /= Parent end, Neighbors),

    case FilteredNeighbors of
        [] -> Profit;
        _ ->
            MaxChildProfit = lists:max(
                lists:map(
                    fun(Neighbor) ->
                        calculate_max_profit(Graph, Neighbor, Node, AlicePath, BobTimes, Amount)
                    end,
                    FilteredNeighbors
                )
            ),
            Profit + MaxChildProfit
    end.