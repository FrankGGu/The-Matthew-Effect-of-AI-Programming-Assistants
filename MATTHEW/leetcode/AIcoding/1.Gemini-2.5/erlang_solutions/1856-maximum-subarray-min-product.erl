-module(solution).
-export([max_subarray_min_product/1]).

max_subarray_min_product(Nums) ->
    N = length(Nums),
    PrefixSumsMap = calculate_prefix_sums(Nums, N),
    LeftSmaller = calculate_left_smaller(Nums, N),
    RightSmaller = calculate_right_smaller(Nums, N),

    calculate_max_product_iter(Nums, LeftSmaller, RightSmaller, PrefixSumsMap, 0, 0).

calculate_prefix_sums(Nums, N) ->
    lists:foldl(fun(X, {CurrentSum, Map, Idx}) ->
                        NewSum = CurrentSum + X,
                        NewMap = maps:put(Idx + 1, NewSum, Map),
                        {NewSum, NewMap, Idx + 1}
                end, {0, #{0 => 0}, 0}, Nums).

calculate_left_smaller(Nums, _N) ->
    get_left_smaller_iter(Nums, 0, [], []).

get_left_smaller_iter([], _Idx, _Stack, Acc) ->
    lists:reverse(Acc);
get_left_smaller_iter([H_val | T_nums], CurrentIdx, Stack, Acc) ->
    NewStack = pop_greater_equal(Stack, H_val),
    LeftIdx = case NewStack of
                  [] -> -1;
                  [{Idx, _Val} | _] -> Idx
              end,
    get_left_smaller_iter(T_nums, CurrentIdx + 1, [{CurrentIdx, H_val} | NewStack], [LeftIdx | Acc]).

calculate_right_smaller(Nums, N) ->
    get_right_smaller_iter(lists:reverse(Nums), N - 1, N, [], []).

get_right_smaller_iter([], _Idx, _N, _Stack, Acc) ->
    lists:reverse(Acc);
get_right_smaller_iter([H_val | T_nums_rev], CurrentIdx, N, Stack, Acc) ->
    NewStack = pop_greater_equal(Stack, H_val),
    RightIdx = case NewStack of
                   [] -> N;
                   [{Idx, _Val} | _] -> Idx
               end,
    get_right_smaller_iter(T_nums_rev, CurrentIdx - 1, N, [{CurrentIdx, H_val} | NewStack], [RightIdx | Acc]).

pop_greater_equal([{S_idx, S_val} | T_stack], CurrentVal) when S_val >= CurrentVal ->
    pop_greater_equal(T_stack, CurrentVal);
pop_greater_equal(Stack, _CurrentVal) ->
    Stack.

calculate_max_product_iter([], _LS, _RS, _PSMap, _Idx, MaxProd) ->
    MaxProd;
calculate_max_product_iter([H_val | T_nums], [H_ls | T_ls], [H_rs | T_rs], PSMap, CurrentIdx, MaxProd) ->
    L = H_ls,
    R = H_rs,
    Sum = maps:get(R, PSMap) - maps:get(L + 1, PSMap),
    CurrentProduct = H_val * Sum,
    NewMaxProd = max(MaxProd, CurrentProduct),
    calculate_max_product_iter(T_nums, T_ls, T_rs, PSMap, CurrentIdx + 1, NewMaxProd).