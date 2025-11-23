-spec number_of_pairs(Points :: [[integer()]]) -> integer().
number_of_pairs(Points) ->
    Sorted = lists:sort(fun([X1, Y1], [X2, Y2]) ->
        if X1 =/= X2 -> X1 < X2;
           true -> Y1 < Y2
        end
    end, Points),
    N = length(Sorted),
    Count = lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            [Xi, Yi] = lists:nth(I, Sorted),
            [Xj, Yj] = lists:nth(J, Sorted),
            case Yi =< Yj of
                true ->
                    Valid = lists:all(fun(K) ->
                        [Xk, Yk] = lists:nth(K, Sorted),
                        not ((Xk >= Xi andalso Xk =< Xj) andalso (Yk >= Yi andalso Yk =< Yj) andalso (Xk /= Xi orelse Yk /= Yi) andalso (Xk /= Xj orelse Yk /= Yj))
                    end, lists:seq(1, N)),
                    case Valid of
                        true -> Acc2 + 1;
                        false -> Acc2
                    end;
                false -> Acc2
            end
        end, Acc1, lists:seq(I + 1, N))
    end, 0, lists:seq(1, N - 1)),
    Count.