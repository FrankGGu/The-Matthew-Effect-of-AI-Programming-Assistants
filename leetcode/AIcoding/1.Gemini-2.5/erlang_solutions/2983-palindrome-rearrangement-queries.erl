-module(solution).
-export([can_make_pali_queries/2]).

popcount(N) -> erlang:popcount(N).

can_make_pali_queries(S, Queries) ->
    N = length(S),
    PrefixXors = build_prefix_xors(S),

    lists:map(fun(Query) ->
        [L1, R1, L2, R2] = Query,
        Mask1 = get_mask(PrefixXors, L1, R1),
        Mask2 = get_mask(PrefixXors, L2, R2),

        check_query(Mask1, Mask2)
    end, Queries).

build_prefix_xors(S) ->
    lists:reverse(lists:foldl(fun(Char, Acc) ->
        [PrevMask | _] = Acc,
        NewMask = PrevMask bxor (1 bsl (Char - $a)),
        [NewMask | Acc]
    end, [0], S)).

get_mask(PrefixXors, L, R) ->
    lists:nth(R + 2, PrefixXors) bxor lists:nth(L + 1, PrefixXors).

check_query(Mask1, Mask2) ->
    if popcount(Mask1) =< 1 andalso popcount(Mask2) =< 1 ->
        true;
    true ->
        D = Mask1 bxor Mask2,
        case popcount(D) of
            0 ->
                popcount(Mask1) =< 3;
            1 ->
                popcount(Mask1) =< 2 orelse popcount(Mask2) =< 2;
            2 ->
                D1_bit = D band (-D),
                D2_bit = D bxor D1_bit,
                popcount(Mask1 bxor D1_bit) =< 2 orelse popcount(Mask1 bxor D2_bit) =< 2;
            _ ->
                false
        end
    end.