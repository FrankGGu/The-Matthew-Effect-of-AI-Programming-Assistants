-module(solution).
-export([count_of_pairs/3]).

count_of_pairs(N, X, Y) ->
    Dist = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    UpdatedDist = update_dist(N, X, Y, Dist),
    count_pairs(UpdatedDist, N).

update_dist(N, X, Y, Dist) ->
    Dist1 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case I =:= J of
                true -> Acc1;
                false ->
                    Old = lists:nth(I, Acc1),
                    New = lists:sublist(Old, 1, J - 1) ++ [abs(I - J)] ++ lists:nthtail(J, Old),
                    lists:sublist(Acc1, 1, I - 1) ++ [New] ++ lists:nthtail(I, Acc1)
            end
        end, Acc, lists:seq(1, N))
    end, Dist, lists:seq(1, N)),
    Dist2 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            Old = lists:nth(I, Acc1),
            Curr = lists:nth(J, Old),
            NewDist = min(Curr, abs(I - X) + 1 + abs(Y - J)),
            New = lists:sublist(Old, 1, J - 1) ++ [NewDist] ++ lists:nthtail(J, Old),
            lists:sublist(Acc1, 1, I - 1) ++ [New] ++ lists:nthtail(I, Acc1)
        end, Acc, lists:seq(1, N))
    end, Dist1, lists:seq(1, N)),
    Dist3 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            Old = lists:nth(I, Acc1),
            Curr = lists:nth(J, Old),
            NewDist = min(Curr, abs(I - Y) + 1 + abs(X - J))),
            New = lists:sublist(Old, 1, J - 1) ++ [NewDist] ++ lists:nthtail(J, Old),
            lists:sublist(Acc1, 1, I - 1) ++ [New] ++ lists:nthtail(I, Acc1)
        end, Acc, lists:seq(1, N))
    end, Dist2, lists:seq(1, N)),
    Dist3.

count_pairs(Dist, N) ->
    Counts = lists:duplicate(N, 0),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            if
                I < J ->
                    D = lists:nth(J, lists:nth(I, Dist)),
                    if
                        D =< N ->
                            Old = lists:nth(D, Acc1),
                            New = lists:sublist(Acc1, 1, D - 1) ++ [Old + 2] ++ lists:nthtail(D, Acc1),
                            New;
                        true -> Acc1
                    end;
                true -> Acc1
            end
        end, Acc, lists:seq(1, N))
    end, Counts, lists:seq(1, N)).