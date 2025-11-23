-module(solution).
-export([minimize_total_price/3]).

build_adj(N, Edges) ->
    lists:foldl(fun([U, V], Acc) ->
        maps:update_with(U, fun(L) -> [V|L] end, [V], Acc),
        maps:update_with(V, fun(L) -> [U|L] end, [U], Acc)
    end, maps:new(), Edges).

create_digraph(N, Edges) ->
    Graph = digraph:new(),
    lists:foreach(fun(I) -> digraph:add_vertex(Graph, I) end, lists:seq(0, N-1)),
    lists:foreach(fun([U, V]) ->
        digraph:add_edge(Graph, U, V),
        digraph:add_edge(Graph, V, U)
    end, Edges),
    Graph.

calculate_frequencies(N, Graph, Trips) ->
    Freqs = array:new(N, {default, 0}),
    lists:foldl(fun([Start, Target], AccFreqs) ->
        Path = digraph:get_shortest_path(Graph, Start, Target),
        lists:foldl(fun(Node, CurrentFreqs) ->
            array:set(Node, array:get(Node, CurrentFreqs) + 1, CurrentFreqs)
        end, AccFreqs, Path)
    end, Freqs, Trips).

dp(Node, Parent, Adj, Freqs, PricesArr, Memo) ->
    case maps:find({Node, 0}, Memo) of
        {ok, Cost0} ->
            Cost1 = maps:get({Node, 1}, Memo),
            {Cost0, Cost1, Memo};
        error ->
            Children = lists:filter(fun(C) -> C /= Parent end, maps:get(Node, Adj, [])),

            Freq = array:get(Node, Freqs),
            Price = array:get(Node, PricesArr),

            Cost_NotHalved_Self = Freq * Price,
            Cost_Halved_Self = (Freq * Price) div 2,

            {FinalCost_NotHalved, FinalCost_Halved, FinalMemo} = lists:foldl(
                fun(Child, {Acc0, Acc1, AccMemo}) ->
                    {ChildCost0, ChildCost1, NewMemo} = dp(Child, Node, Adj, Freqs, PricesArr, AccMemo),

                    NewAcc0 = Acc0 + min(ChildCost0, ChildCost1),
                    NewAcc1 = Acc1 + ChildCost0,

                    {NewAcc0, NewAcc1, NewMemo}
                end,
                {Cost_NotHalved_Self, Cost_Halved_Self, Memo},
                Children
            ),

            NewMemo1 = maps:put({Node, 0}, FinalCost_NotHalved, FinalMemo),
            NewMemo2 = maps:put({Node, 1}, FinalCost_Halved, NewMemo1),

            {FinalCost_NotHalved, FinalCost_Halved, NewMemo2}
    end.

minimize_total_price(Prices, Edges, Trips) ->
    N = length(Prices),
    PricesArr = array:from_list(Prices),

    Adj = build_adj(N, Edges),

    Graph = create_digraph(N, Edges),
    Freqs = calculate_frequencies(N, Graph, Trips),

    digraph:delete(Graph),

    Memo = maps:new(),
    {Cost0, Cost1, _FinalMemo} = dp(0, -1, Adj, Freqs, PricesArr, Memo),

    min(Cost0, Cost1).