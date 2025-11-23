-module(solution).
-export([min_start_value/2]).

min_start_value( nums, k) ->
    ok = length(nums) > 0,
    ok = k > 0,
    get_min_value(nums, k, 0, 0).

get_min_value([], _, _, Result) -> Result;
get_min_value(Nums, K, Start, Result) ->
    Total = lists:sum(Nums),
    Robbed = rob(Nums, Start),
    case Robbed of
        RobbedValue when RobbedValue >= K -> 
            get_min_value([], K, Start + 1, Start + 1);
        _ ->
            get_min_value(tl(Nums), K, Start, Result)
    end.

rob([]) -> 0;
rob([H]) -> H;
rob([H1, H2]) -> max(H1, H2);
rob([H | T]) ->
    Prev1 = rob(tl(T)),
    Prev2 = rob(tl(tl(T))),
    max(H + Prev2, Prev1).

max(A, B) -> if A > B -> A; true -> B end.