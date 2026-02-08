-module(solution).
-export([largest_overlap/2]).

largest_overlap(A, B) ->
    {N, M} = {length(A), length(hd(A))},
    MaxOverlap = lists:foldl(fun({x_offset, y_offset}, Acc) ->
        Acc1 = lists:foldl(fun({X, Row}, Acc2) ->
            lists:foldl(fun({Y, Val}, Acc3) ->
                case Val of
                    1 -> 
                        case lists:nth(Y + y_offset + 1, B) of
                            [] -> Acc3;
                            RowB -> 
                                case lists:nth(X + x_offset + 1, RowB) of
                                    1 -> Acc3 + 1;
                                    _ -> Acc3
                                end
                        end;
                    _ -> Acc3
                end
            end, Acc2, lists:zip(lists:seq(1, N), Row))
        end, Acc1, lists:zip(lists:seq(1, N), A)),
        Max = max(Acc1, Acc),
        Max
    end, 0, generate_offsets(N, M)),
    MaxOverlap.

generate_offsets(N, M) ->
    lists:flatmap(fun(X) -> 
        lists:map(fun(Y) -> {X, Y} end, lists:seq(-N + 1, N - 1))
    end, lists:seq(-M + 1, M - 1)).