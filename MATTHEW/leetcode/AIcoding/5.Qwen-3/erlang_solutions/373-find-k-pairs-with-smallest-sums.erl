-module(solution).
-export([k_smallest_pairs/2]).

k_smallest_pairs([], _) -> [];
k_smallest_pairs(_, 0) -> [];
k_smallest_pairs(A, B) ->
    k_smallest_pairs(A, B, 1, []).

k_smallest_pairs(_, _, _, Acc) when length(Acc) >= 5000 -> Acc;
k_smallest_pairs([], _, _, Acc) -> Acc;
k_smallest_pairs(_, 0, _, Acc) -> Acc;
k_smallest_pairs(A, B, K, Acc) ->
    {Min, List} = lists:foldl(
        fun({I, J}, {MinVal, MinList}) ->
            Sum = lists:nth(I+1, A) + lists:nth(J+1, B),
            if
                Sum < MinVal -> {Sum, [{lists:nth(I+1, A), lists:nth(J+1, B)}]};
                Sum == MinVal -> {Sum, [ {lists:nth(I+1, A), lists:nth(J+1, B)} | MinList ]};
                true -> {MinVal, MinList}
            end
        end,
        {infinity, []},
        lists:seq(0, length(A)-1)
    ),
    case List of
        [] -> Acc;
        _ ->
            NewAcc = Acc ++ List,
            k_smallest_pairs(A, B, K - length(List), NewAcc)
    end.