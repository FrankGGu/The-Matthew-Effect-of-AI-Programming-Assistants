-module(solution).
-export([max_product/1]).

max_product(S) ->
    N = length(S),
    Max = 1 bsl N,
    MaxProduct = 0,
    find_max_product(S, 0, Max - 1, MaxProduct).

find_max_product(_, I, Max, MaxProduct) when I >= Max ->
    MaxProduct;
find_max_product(S, I, Max, MaxProduct) ->
    Subseq1 = get_subsequence(S, I),
    case is_palindrome(Subseq1) of
        true ->
            Len1 = length(Subseq1),
            J = (I + 1) band (Max - 1),
            NewMaxProduct = find_max_product_helper(S, J, Max, Len1, MaxProduct),
            find_max_product(S, I + 1, Max, NewMaxProduct);
        false ->
            find_max_product(S, I + 1, Max, MaxProduct)
    end.

find_max_product_helper(_, J, Max, _, MaxProduct) when J >= Max ->
    MaxProduct;
find_max_product_helper(S, J, Max, Len1, MaxProduct) ->
    Subseq2 = get_subsequence(S, J),
    case is_palindrome(Subseq2) of
        true ->
            Len2 = length(Subseq2),
            Product = Len1 * Len2,
            if
                Product > MaxProduct ->
                    find_max_product_helper(S, J + 1, Max, Len1, Product);
                true ->
                    find_max_product_helper(S, J + 1, Max, Len1, MaxProduct)
            end;
        false ->
            find_max_product_helper(S, J + 1, Max, Len1, MaxProduct)
    end.

get_subsequence(S, Mask) ->
    get_subsequence(S, Mask, 0, []).

get_subsequence([], _, _, Acc) ->
    lists:reverse(Acc);
get_subsequence([H|T], Mask, Pos, Acc) ->
    case (Mask band (1 bsl Pos)) =/= 0 of
        true ->
            get_subsequence(T, Mask, Pos + 1, [H|Acc]);
        false ->
            get_subsequence(T, Mask, Pos + 1, Acc)
    end.

is_palindrome(S) ->
    S == lists:reverse(S).