-module(solution).
-export([find_maximum_xor/1]).

find_maximum_xor(Nums) ->
    MaxXor = 0,
    Mask = 0,
    find_maximum_xor(Nums, MaxXor, Mask, 31).

find_maximum_xor(_, MaxXor, _, -1) -> MaxXor;
find_maximum_xor(Nums, MaxXor, Mask, I) ->
    NewMask = Mask bor (1 bsl I),
    Prefixes = sets:from_list([Num band NewMask || Num <- Nums]),
    Temp = MaxXor bor (1 bsl I),
    case has_pair(Prefixes, Temp) of
        true -> find_maximum_xor(Nums, Temp, NewMask, I - 1);
        false -> find_maximum_xor(Nums, MaxXor, Mask, I - 1)
    end.

has_pair(Prefixes, Temp) ->
    sets:fold(fun(Prefix, Acc) ->
        case sets:is_element(Prefix bxor Temp, Prefixes) of
            true -> true;
            false -> Acc
        end
    end, false, Prefixes).