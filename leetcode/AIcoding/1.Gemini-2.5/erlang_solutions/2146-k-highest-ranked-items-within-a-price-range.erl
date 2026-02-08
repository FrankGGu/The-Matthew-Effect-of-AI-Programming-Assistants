-module(solution).
-export([highest_ranked_items/4]).

highest_ranked_items(Grid, PriceRange, Start, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    StartR = hd(Start),
    StartC = hd(tl(Start)),

    InitialQueue = queue:in({0, StartR, StartC}, queue:new()),
    InitialVisited = sets:add({StartR, StartC}, sets:new()),

    Candidates = bfs(InitialQueue, InitialVisited, [], Grid, PriceRange, Rows, Cols),

    SortedCandidates = lists:sort(Candidates),

    TopKCandidates = lists:sublist(SortedCandidates, K),

    lists:map(fun({_, _, R, C}) -> [R, C] end, TopKCandidates).

bfs(Queue, Visited, CandidatesAcc, Grid, PriceRange, Rows, Cols) ->
    case queue:out(Queue) of
        {{value, {Dist, R, C}}, RestQueue} ->
            ItemPrice = lists:nth(C + 1, lists:nth(R + 1, Grid)),

            NewCandidatesAcc = 
                if ItemPrice >= hd(PriceRange) andalso ItemPrice =< hd(tl(PriceRange)) andalso ItemPrice > 0 ->
                    [{Dist, ItemPrice, R, C} | CandidatesAcc];
                true ->
                    CandidatesAcc
                end,

            Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

            {NextQueue, NextVisited} = lists:foldl(
                fun({NR, NC}, {AccQ, AccV}) ->
                    if NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols andalso
                       lists:nth(NC + 1, lists:nth(NR + 1, Grid)) =/= 0 andalso
                       not sets:is_element({NR, NC}, AccV) ->
                        {queue:in({Dist + 1, NR, NC}, AccQ), sets:add({NR, NC}, AccV)};
                    true ->
                        {AccQ, AccV}
                    end
                end,
                {RestQueue, Visited},
                Neighbors
            ),

            bfs(NextQueue, NextVisited, NewCandidatesAcc, Grid, PriceRange, Rows, Cols);
        {empty, _} ->
            CandidatesAcc
    end.