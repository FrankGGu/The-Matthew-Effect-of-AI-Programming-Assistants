-module(solution).
-export([min_cost/2]).

min_cost(Houses, Cost) ->
    N = length(Houses),
    M = length(Cost),
    dp(Houses, Cost, N, M).

dp(Houses, Cost, N, M) ->
    dp_helper(Houses, Cost, 1, N, M, 0, 0, 0, 0).

dp_helper(_, _, N, _, _, _, _, _, _) when N > 0 ->
    infinity;
dp_helper(Houses, Cost, I, N, M, LastColor, CurrentCost, TotalHouses, Result) ->
    case element(I, Houses) of
        0 ->
            (1..M) |> lists:foldl(fun Color, Acc ->
                case Color =:= LastColor of
                    true -> Acc;
                    false -> 
                        NewCost = CurrentCost + lists:nth(Color, lists:nth(I, Cost)),
                        NewResult = dp_helper(Houses, Cost, I + 1, N, M, Color, NewCost, TotalHouses, Acc),
                        min(Acc, NewResult)
                end
            end, infinity);
        Color ->
            NewResult = dp_helper(Houses, Cost, I + 1, N, M, Color, CurrentCost, TotalHouses, Result),
            min(Result, NewResult)
    end.

min(A, B) when A < B -> A;
min(A, B) -> B.

infinity -> 99999999.