-module(solution).
-export([get_good_indices/2]).

get_good_indices(Variables, Target) ->
    N = length(Variables),
    lists:foldl(
        fun(I, Acc) ->
            [[A, B, C, M]] = lists:sublist(Variables, I+1, 1),
            Pow1 = pow_mod(A, pow_mod(B, C, 10), M),
            Pow2 = pow_mod(pow_mod(A, B, M), C, M),
            case (Pow1 == Target) and (Pow2 == Target) of
                true -> [I | Acc];
                false -> Acc
            end
        end,
        [],
        lists:seq(0, N-1)
    ).

pow_mod(Base, Exp, Mod) when Exp == 0 -> 1;
pow_mod(Base, Exp, Mod) ->
    case Exp rem 2 of
        0 -> 
            Half = pow_mod(Base, Exp div 2, Mod),
            (Half * Half) rem Mod;
        1 -> 
            (Base * pow_mod(Base, Exp - 1, Mod)) rem Mod
    end.