-module(solution).
-export([find_maximum_xor/1]).

find_maximum_xor(Nums) ->
    Max = lists:max(Nums),
    if Max == 0 -> 0;
       true ->
            L = floor(math:log2(Max)) + 1,
            MaxXor = 0,
            Mask = 0,
            find_max_xor(Nums, L, MaxXor, Mask)
    end.

find_max_xor(Nums, 0, MaxXor, _Mask) ->
    MaxXor;
find_max_xor(Nums, I, MaxXor, Mask) ->
    Mask = Mask bor (1 bsl (I - 1)),
    PrefixSet = sets:from_list([Num band Mask || Num <- Nums]),
    NewMaxXor = MaxXor bor (1 bsl (I - 1)),
    case check_prefixes(PrefixSet, NewMaxXor) of
        true -> find_max_xor(Nums, I - 1, NewMaxXor, Mask);
        false -> find_max_xor(Nums, I - 1, MaxXor, Mask)
    end.

check_prefixes(PrefixSet, NewMaxXor) ->
    sets:fold(fun(Prefix, Acc) ->
        case sets:is_element(Prefix bxor NewMaxXor, PrefixSet) of
            true -> true;
            false -> Acc
        end
    end, false, PrefixSet).