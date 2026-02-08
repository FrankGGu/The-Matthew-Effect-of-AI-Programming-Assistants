-module(min_swaps_kth_smallest).
-export([get_min_swaps/2]).

get_min_swaps(Num, K) ->
    Nums = string:to_integer_list(Num),
    Target = kth_smallest(Nums, K),
    get_min_swaps_helper(Nums, Target, 0).

kth_smallest(Nums, K) ->
    lists:nth(K, kth_smallest_helper(Nums, 1, [Nums])).

kth_smallest_helper(Nums, Count, Acc) when Count >= K ->
    lists:sort(lists:flatten(Acc));
kth_smallest_helper(Nums, Count, Acc) ->
    Perms = next_permutation(lists:flatten(lists:last(Acc))),
    kth_smallest_helper(Nums, Count + 1, Acc ++ [Perms]).

next_permutation(Nums) ->
    N = length(Nums),
    {I, ValI} = find_first_decreasing_from_right(Nums, N - 2),
    if
        I == -1 ->
            lists:reverse(Nums);
        true ->
            {J, ValJ} = find_first_greater_than_from_right(Nums, ValI, N - 1),
            Swapped = swap(Nums, I, J),
            {Left, Right} = lists:split(I + 1, Swapped),
            Left ++ lists:reverse(Right)
    end.

find_first_decreasing_from_right(Nums, I) when I < 0 ->
    {-1, -1};
find_first_decreasing_from_right(Nums, I) ->
    if
        lists:nth(I, Nums) < lists:nth(I + 1, Nums) ->
            {I, lists:nth(I, Nums)};
        true ->
            find_first_decreasing_from_right(Nums, I - 1)
    end.

find_first_greater_than_from_right(Nums, Val, J) when J < 0 ->
    {-1, -1};
find_first_greater_than_from_right(Nums, Val, J) ->
    if
        lists:nth(J, Nums) > Val ->
            {J, lists:nth(J, Nums)};
        true ->
            find_first_greater_than_from_right(Nums, Val, J - 1)
    end.

swap(Nums, I, J) ->
    lists:map(fun(K) ->
                      case K of
                          I -> lists:nth(J, Nums);
                          J -> lists:nth(I, Nums);
                          _ -> lists:nth(K, Nums)
                      end
              end, lists:seq(0, length(Nums) - 1)).

get_min_swaps_helper(Nums, Target, Swaps) ->
    if
        Nums == Target ->
            Swaps;
        true ->
            {I, _} = lists:keyfind(hd(Target), 1, lists:zip(lists:seq(0, length(Nums) - 1), Nums)),
            Swapped = swap_to_front(Nums, I),
            get_min_swaps_helper(tl(Swapped), tl(Target), Swaps + I)
    end.

swap_to_front(Nums, I) ->
    swap_to_front_helper(Nums, I, []).

swap_to_front_helper(Nums, 0, Acc) ->
    lists:reverse(Acc) ++ Nums;
swap_to_front_helper(Nums, I, Acc) ->
    swap_to_front_helper(swap_adjacent(Nums, I), I - 1, [hd(Nums) | Acc]).

swap_adjacent(Nums, I) ->
    lists:map(fun(K) ->
                      case K of
                          I - 1 -> lists:nth(I, Nums);
                          I -> lists:nth(I - 1, Nums);
                          _ -> lists:nth(K, Nums)
                      end
              end, lists:seq(0, length(Nums) - 1)).