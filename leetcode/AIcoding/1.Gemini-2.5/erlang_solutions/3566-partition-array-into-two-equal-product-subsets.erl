-module(solution).
-export([can_partition_array_into_two_equal_product_subsets/1]).

can_partition_array_into_two_equal_product_subsets(Nums) ->
    N = length(Nums),
    if N < 2 ->
        false;
    true ->
        PrefixProducts = calculate_prefix_products(Nums),
        SuffixProducts = calculate_suffix_products(Nums),
        check_partitions(lists:droplast(PrefixProducts), lists:tl(SuffixProducts))
    end.

calculate_prefix_products(Nums) ->
    lists:foldl(fun(X, Acc) ->
                        case Acc of
                            [] -> [X];
                            [H|_] -> [H * X | Acc]
                        end
                end, [], Nums) |> lists:reverse.

calculate_suffix_products(Nums) ->
    lists:foldr(fun(X, Acc) ->
                        case Acc of
                            [] -> [X];
                            [H|_] -> [X * H | Acc]
                        end
                end, [], Nums).

check_partitions([], []) -> false;
check_partitions([P|Pt], [S|St]) ->
    if P == S ->
        true;
    true ->
        check_partitions(Pt, St)
    end.