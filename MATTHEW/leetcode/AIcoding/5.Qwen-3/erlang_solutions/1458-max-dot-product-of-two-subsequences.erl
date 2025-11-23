-module(max_dot_product).
-export([max_dot_product/2]).

max_dot_product(A, B) ->
    N = length(A),
    M = length(B),
    DP = array:new([{size, N+1}, {default, 0}]),
    max_dot_product(A, B, N, M, DP).

max_dot_product(_, _, 0, _, _) ->
    0;
max_dot_product(_, _, _, 0, _) ->
    0;
max_dot_product(A, B, I, J, DP) ->
    case array:get(I, DP) of
        Row when is_list(Row) ->
            case lists:nth(J, Row) of
                Val when is_integer(Val) ->
                    Val;
                _ ->
                    compute_value(A, B, I, J, DP)
            end;
        _ ->
            compute_value(A, B, I, J, DP)
    end.

compute_value(A, B, I, J, DP) ->
    AVal = lists:nth(I, A),
    BVal = lists:nth(J, B),
    Case1 = max_dot_product(A, B, I-1, J, DP),
    Case2 = max_dot_product(A, B, I, J-1, DP),
    Case3 = max_dot_product(A, B, I-1, J-1, DP) + AVal * BVal,
    Max = max(Case1, max(Case2, Case3)),
    NewDP = array:set(I, array:set(J, Max, array:get(I, DP)), DP),
    Max.