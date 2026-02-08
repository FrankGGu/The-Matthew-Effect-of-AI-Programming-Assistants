-module(solution).
-export([is_possible_to_split/1]).

is_possible_to_split(Nums) ->
    Prefix = compute_prefix(Nums),
    Suffix = compute_suffix(Nums),
    check_split(Prefix, Suffix, 1, length(Nums) - 1).

compute_prefix(Nums) ->
    compute_prefix(Nums, 1, []).

compute_prefix([], _, Acc) ->
    lists:reverse(Acc);
compute_prefix([H | T], Product, Acc) ->
    NewProduct = Product * H,
    compute_prefix(T, NewProduct, [NewProduct | Acc]).

compute_suffix(Nums) ->
    compute_suffix(Nums, 1, []).

compute_suffix([], _, Acc) ->
    Acc;
compute_suffix([H | T], Product, Acc) ->
    NewProduct = Product * H,
    compute_suffix(T, NewProduct, [NewProduct | Acc]).

check_split(_, _, Index, Length) when Index > Length ->
    false;
check_split([PrefixH | PrefixT], [SuffixH | SuffixT], Index, Length) ->
    case gcd(PrefixH, SuffixT) of
        1 -> true;
        _ -> check_split(PrefixT, SuffixT, Index + 1, Length)
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).