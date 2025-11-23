-module(maximal_network_rank).
-export([maximal_network_rank/2]).

maximal_network_rank(N, Roads) ->
    AdjList = create_adj_list(N, Roads),
    max_rank(N, AdjList).

create_adj_list(N, Roads) ->
    lists:foldl(
        fun([U, V], Acc) ->
            U1 = U + 1,
            V1 = V + 1,
            Acc#{U1 => lists:append(maps:get(U1, Acc, []), [V1]),
                  V1 => lists:append(maps:get(V1, Acc, []), [U1])}
        end,
        maps:new(),
        Roads
    ).

max_rank(N, AdjList) ->
    lists:foldl(
        fun(I, MaxRankSoFar) ->
            lists:foldl(
                fun(J, InnerMaxRank) ->
                    case I >= J of
                        true ->
                            InnerMaxRank;
                        false ->
                            RankI = length(maps:get(I, AdjList, [])),
                            RankJ = length(maps:get(J, AdjList, [])),
                            Rank = RankI + RankJ - (case lists:member(J, maps:get(I, AdjList, [])) of
                                                        true -> 1;
                                                        false -> 0
                                                    end),
                            max(InnerMaxRank, Rank)
                    end
                end,
                MaxRankSoFar,
                lists:seq(1, N)
            )
        end,
        0,
        lists:seq(1, N)
    ).