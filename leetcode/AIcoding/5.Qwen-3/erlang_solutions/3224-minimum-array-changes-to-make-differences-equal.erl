-module(solution).
-export([min_changes/1]).

min_changes(A) ->
    N = length(A),
    if
        N < 2 -> 0;
        true ->
            Lists = lists:seq(1, N-1),
            lists:foldl(fun(I, Acc) ->
                                Diff = abs(lists:nth(I, A) - lists:nth(I+1, A)),
                                case Acc of
                                    [] -> [Diff];
                                    _ -> [Diff | Acc]
                                end
                        end, [], Lists),
            Sorted = lists:sort(lists:reverse(Lists)),
            Count = lists:foldl(fun(D, C) ->
                                        case D of
                                            D when D == 0 -> C + 1;
                                            _ -> C
                                        end
                                    end, 0, Sorted),
            N - Count - 1
    end.