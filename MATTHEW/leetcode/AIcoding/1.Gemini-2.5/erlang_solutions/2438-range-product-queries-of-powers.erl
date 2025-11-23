-module(solution).
-export([productQueries/2]).

productQueries(N, Queries) ->
    MOD = 1000000007,
    Powers = get_powers(N),

    PrefixProducts = lists:foldl(fun(P, Acc) ->
                                     [ (hd(Acc) * P) rem MOD | Acc ]
                                 end, [1], lists:reverse(Powers)),
    PrefixProductsReversed = lists:reverse(PrefixProducts),

    lists:map(fun([L, R]) ->
                  ProdR = lists:nth(R + 2, PrefixProductsReversed),
                  ProdL = lists:nth(L + 1, PrefixProductsReversed),

                  (ProdR * modular_inverse(ProdL, MOD)) rem MOD
              end, Queries).

get_powers(N) ->
    get_powers(N, 0, []).

get_powers(0, _, Acc) ->
    lists:reverse(Acc);
get_powers(N, PowerIdx, Acc) ->
    case N band 1 of
        1 ->
            get_powers(N bsr 1, PowerIdx + 1, [1 bsl PowerIdx | Acc]);
        0 ->
            get_powers(N bsr 1, PowerIdx + 1, Acc)
    end.

modular_inverse(A, M) ->
    power(A, M - 2, M).

power(Base, Exp, Mod) ->
    power(Base, Exp, Mod, 1).

power(_, 0, _, Acc) ->
    Acc;
power(Base, Exp, Mod, Acc) ->
    NewAcc = case Exp band 1 of
                 1 -> (Acc * Base) rem Mod;
                 0 -> Acc
             end,
    power((Base * Base) rem Mod, Exp bsr 1, Mod, NewAcc).