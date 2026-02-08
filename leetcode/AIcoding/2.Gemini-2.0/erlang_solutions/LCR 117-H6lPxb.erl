-module(similar_string_groups).
-export([num_similar_groups/1]).

num_similar_groups(Strs) ->
    N = length(Strs),
    DSU = dsu:new(N),
    lists:foreach(fun(I) ->
                      lists:foreach(fun(J) ->
                                        if I < J andalso are_similar(lists:nth(I+1, Strs), lists:nth(J+1, Strs)) ->
                                            dsu:union(DSU, I, J)
                                        else
                                            ok
                                        end
                                    end, lists:seq(1, N))
                  end, lists:seq(1, N)),
    lists:foldl(fun(I, Acc) ->
                       if dsu:find(DSU, I) == I ->
                           Acc + 1
                       else
                           Acc
                       end
                   end, 0, lists:seq(0, N-1)).

are_similar(S1, S2) ->
    Diff = lists:zipwith(fun(C1, C2) ->
                               if C1 == C2 ->
                                   0
                               else
                                   1
                               end
                           end, string:to_list(S1), string:to_list(S2)),
    Sum = lists:sum(Diff),
    Sum == 0 orelse Sum == 2.

-module(dsu).
-export([new/1, find/2, union/3]).

new(N) ->
    {array:new(N, {parent, 0}), array:new(N, {rank, 0})}.

find({Parents, _Ranks}, X) ->
    find_helper(Parents, X).

find_helper(Parents, X) ->
    case array:get(X, Parents) of
        {parent, X} ->
            X;
        {parent, P} ->
            Root = find_helper(Parents, P),
            array:set(X, {parent, Root}, Parents),
            Root
    end.

union({Parents, Ranks}, X, Y) ->
    RootX = find({Parents, Ranks}, X),
    RootY = find({Parents, Ranks}, Y),
    if RootX == RootY ->
        ok
    else
        RankX = array:get(RootX, Ranks),
        RankY = array:get(RootY, Ranks),
        case RankX > RankY of
            true ->
                array:set(RootY, {parent, RootX}, Parents);
            false ->
                array:set(RootX, {parent, RootY}, Parents),
                if RankX == RankY ->
                    array:set(RootY, {rank, RankY + 1}, Ranks)
                else
                    ok
                end
        end
    end.