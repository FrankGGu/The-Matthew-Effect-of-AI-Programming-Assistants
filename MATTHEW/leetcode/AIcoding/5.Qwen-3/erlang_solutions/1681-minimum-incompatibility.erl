-module(minimum_incompatibility).
-export([min_incompatibility/2]).

min_incompatibility(Nums, k) ->
    N = length(Nums),
    if
        N rem k /= 0 -> -1;
        true -> solve(Nums, k, N div k, 0, 0, 0, 0, 0, [], [])
    end.

solve(_, _, _, _, _, _, _, _, _, _) -> -1;
solve(Nums, K, Size, Start, Count, Sum, Min, Max, Used, Result) ->
    case Count of
        Size ->
            NewResult = lists:append(Result, [Sum]),
            solve(Nums, K, Size, 0, 0, 0, 0, 0, [], NewResult);
        _ ->
            case Start of
                N when N == length(Nums) -> -1;
                _ ->
                    case lists:nth(Start + 1, Used) of
                        1 -> solve(Nums, K, Size, Start + 1, Count, Sum, Min, Max, Used, Result);
                        _ ->
                            Val = lists:nth(Start + 1, Nums),
                            case Count of
                                0 ->
                                    NewUsed = lists:sublist(Used, Start) ++ [1] ++ lists:nthtail(Start + 1, Used),
                                    solve(Nums, K, Size, Start + 1, 1, Val, Val, Val, NewUsed, Result);
                                _ ->
                                    case (Val >= Min andalso Val <= Max) of
                                        true ->
                                            NewUsed = lists:sublist(Used, Start) ++ [1] ++ lists:nthtail(Start + 1, Used),
                                            NewSum = Sum + Val,
                                            NewMin = min(Min, Val),
                                            NewMax = max(Max, Val),
                                            solve(Nums, K, Size, Start + 1, Count + 1, NewSum, NewMin, NewMax, NewUsed, Result);
                                        false ->
                                            solve(Nums, K, Size, Start + 1, Count, Sum, Min, Max, Used, Result)
                                    end
                            end
                    end
            end
    end.