-module(subarray_distinct_element_sum_squares_ii).
-export([distinct_element_sum_squares/1]).

distinct_element_sum_squares(Nums) ->
    distinct_element_sum_squares(Nums, 0).

distinct_element_sum_squares([], Acc) ->
    Acc rem 1000000007;
distinct_element_sum_squares([H|T], Acc) ->
    distinct_element_sum_squares(T, (Acc + solve([H], [H])) rem 1000000007).

solve([], _) -> 0;
solve([H|T], Distinct) ->
    case lists:member(H, Distinct) of
        true ->
            solve(T, Distinct);
        false ->
            case T of
                [] ->
                    (H * H) rem 1000000007;
                _ ->
                    (H * H + solve(T, lists:usort([H|Distinct]))) rem 1000000007
            end
    end.