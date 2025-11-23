-module(solution).
-export([min_mutation/3]).

diff_by_one(Gene1, Gene2) ->
    diff_by_one_impl(Gene1, Gene2, 0).

diff_by_one_impl([], [], 1) -> true;
diff_by_one_impl([], [], _) -> false;
diff_by_one_impl([_H1|_T1], [_H2|_T2], DiffCount) when DiffCount > 1 -> false;
diff_by_one_impl([H1|T1], [H2|T2], DiffCount) ->
    case H1 == H2 of
        true -> diff_by_one_impl(T1, T2, DiffCount);
        false -> diff_by_one_impl(T1, T2, DiffCount + 1)
    end.

min_mutation(StartGene, EndGene, Bank) ->
    if StartGene == EndGene -> 0;
       true ->
            Q0 = queue:new(),
            Q1 = queue:in({StartGene, 0}, Q0),
            Visited0 = sets:new(),
            Visited1 = sets:add_element(StartGene, Visited0),
            bfs(Q1, Visited1, EndGene, Bank)
    end.

bfs(Q, Visited, EndGene, Bank) ->
    case queue:out(Q) of
        {{value, {CurrentGene, Mutations}}, RestQ} ->
            if CurrentGene == EndGene ->
                Mutations;
            true ->
                Neighbors = [NextGene || NextGene <- Bank,
                                        not sets:is_element(NextGene, Visited),
                                        diff_by_one(CurrentGene, NextGene)],

                {NewQ, NewVisited} = lists:foldl(
                    fun(Neighbor, {AccQ, AccVisited}) ->
                        {queue:in({Neighbor, Mutations + 1}, AccQ),
                         sets:add_element(Neighbor, AccVisited)}
                    end,
                    {RestQ, Visited},
                    Neighbors
                ),
                bfs(NewQ, NewVisited, EndGene, Bank)
            end;
        {empty, _} ->
            -1
    end.