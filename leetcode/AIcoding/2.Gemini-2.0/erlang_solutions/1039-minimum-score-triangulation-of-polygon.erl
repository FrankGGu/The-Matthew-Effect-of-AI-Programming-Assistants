-module(minimum_score_triangulation).
-export([min_score_triangulation/1]).

min_score_triangulation(Values) ->
    N = length(Values),
    DP = array:new([N + 1, N + 1], {default, 0}),
    min_score_triangulation_helper(Values, 1, N, DP).

min_score_triangulation_helper(Values, I, J, DP) ->
    case I >= J - 1 of
        true ->
            0;
        false ->
            case array:get([I, J], DP) of
                {default, _} ->
                    Result = lists:foldl(
                        fun(K, Acc) ->
                            Val = element(I, Values) * element(K, Values) * element(J, Values) +
                                min_score_triangulation_helper(Values, I, K, DP) +
                                min_score_triangulation_helper(Values, K, J, DP);
                            min(Acc, Val)
                        end,
                        infinity,
                        lists:seq(I + 1, J - 1)
                    );
                    array:set([I, J], Result, DP),
                    Result;
                Val ->
                    Val
            end
    end.

element(I, List) ->
    lists:nth(I, List).