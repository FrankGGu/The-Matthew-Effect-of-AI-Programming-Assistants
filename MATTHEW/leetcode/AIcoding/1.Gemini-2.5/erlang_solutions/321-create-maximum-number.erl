-module(solution).
-export([maxNumber/3]).

maxNumber(Nums1, Nums2, K) ->
    Len1 = length(Nums1),
    Len2 = length(Nums2),

    StartI = max(0, K - Len2),
    EndI = min(K, Len1),

    iterate_splits(Nums1, Nums2, K, StartI, EndI, []).

iterate_splits(_, _, _, I, EndI, CurrentMax) when I > EndI ->
    CurrentMax;
iterate_splits(Nums1, Nums2, K, I, EndI, CurrentMax) ->
    J = K - I, % Number of digits from Nums2

    Sub1 = max_array(Nums1, I),
    Sub2 = max_array(Nums2, J),

    Merged = merge(Sub1, Sub2),

    NewMax = if is_greater(Merged, CurrentMax) -> Merged;
             true -> CurrentMax
             end,

    iterate_splits(Nums1, Nums2, K, I + 1, EndI, NewMax).

max_array(Nums, K) ->
    Len = length(Nums),
    ToDrop = Len - K,
    max_array_stack_rev(Nums, K, ToDrop, []).

max_array_stack_rev([], K, _, Stack) ->
    lists:reverse(lists:sublist(Stack, K));
max_array_stack_rev([H | T], K, ToDrop, Stack) ->
    {NewStack, NewToDrop} = pop_smaller_rev(H, ToDrop, Stack),
    max_array_stack_rev(T, K, NewToDrop, [H | NewStack]).

pop_smaller_rev(H, ToDrop, Stack) ->
    if ToDrop > 0 andalso Stack =/= [] andalso hd(Stack) < H ->
        pop_smaller_rev(H, ToDrop - 1, tl(Stack));
    true ->
        {Stack, ToDrop}
    end.

merge(Arr1, Arr2) ->
    merge_impl(Arr1, Arr2, []).

merge_impl([], Arr2, Acc) -> lists:reverse(Acc) ++ Arr2;
merge_impl(Arr1, [], Acc) -> lists:reverse(Acc) ++ Arr1;
merge_impl(Arr1, Arr2, Acc) ->
    if is_greater(Arr1, Arr2) ->
        merge_impl(tl(Arr1), Arr2, [hd(Arr1) | Acc]);
    true ->
        merge_impl(Arr1, tl(Arr2), [hd(Arr2) | Acc])
    end.

is_greater(List1, List2) ->
    is_greater_impl(List1, List2).

is_greater_impl([], []) -> false;
is_greater_impl([], _) -> false;
is_greater_impl(_, []) -> true;
is_greater_impl([H1 | T1], [H2 | T2]) ->
    if H1 > H2 -> true;
    H1 < H2 -> false;
    true -> is_greater_impl(T1, T2)
    end.