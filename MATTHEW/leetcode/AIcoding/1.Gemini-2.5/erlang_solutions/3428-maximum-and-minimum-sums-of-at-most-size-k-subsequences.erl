-module(solution).
-export([max_min_sum_subsequences/2]).

mult(A, B, M) ->
    (A * B) rem M.

add(A, B, M) ->
    (A + B) rem M.

pow_mod(_, 0, _, Acc) -> Acc;
pow_mod(Base, Exp, Mod, Acc) when Exp rem 2 == 1 ->
    pow_mod(mult(Base, Base, Mod), Exp div 2, Mod, mult(Acc, Base, Mod));
pow_mod(Base, Exp, Mod, Acc) ->
    pow_mod(mult(Base, Base, Mod), Exp div 2, Mod, Acc).

power(Base, Exp, Mod) ->
    pow_mod(Base, Exp, Mod, 1).

inv_mod(N, M) ->
    power(N, M - 2, M).

precompute_factorials(N, M) ->
    Facs = array:new([{fixed, true}, {size, N + 1}]),
    InvFacs = array:new([{fixed, true}, {size, N + 1}]),
    array:set(0, 1, Facs),
    array:set(0, 1, InvFacs),
    Fac = fun F(I, CurrentFac) when I =< N ->
                  NextFac = mult(CurrentFac, I, M),
                  array:set(I, NextFac, Facs),
                  F(I + 1, NextFac);
             F(_, _) -> ok
          end,
    Fac(1, 1),

    InvFacN = inv_mod(array:get(N, Facs), M),
    array:set(N, InvFacN, InvFacs),
    InvFac = fun F(I, CurrentInvFac) when I >= 1 ->
                     NextInvFac = mult(CurrentInvFac, I, M),
                     array:set(I - 1, NextInvFac, InvFacs),
                     F(I - 1, NextInvFac);
                F(_, _) -> ok
             end,
    InvFac(N, InvFacN),
    {Facs, InvFacs}.

ncr(N, R, M, Facs, InvFacs) when R < 0; R > N -> 0;
ncr(N, R, M, Facs, InvFacs) ->
    mult(array:get(N, Facs), mult(array:get(R, InvFacs), array:get(N - R, InvFacs), M), M).

max_min_sum_subsequences(Nums, K) ->
    N = length(Nums),
    SortedNums = lists:sort(Nums),
    Mod = 1000000007,

    {Facs, InvFacs} = precompute_factorials(N, Mod),

    %% Precompute powers of 2
    Pow2 = array:new([{fixed, true}, {size, N + 1}]),
    array:set(0, 1, Pow2),
    Pow = fun F(I, CurrentPow) when I =< N ->
                  NextPow = mult(CurrentPow, 2, Mod),
                  array:set(I, NextPow, Pow2),
                  F(I + 1, NextPow);
             F(_, _) -> ok
          end,
    Pow(1, 1),

    K_prime = K - 2,

    %% P_arr[L] = sum_{m=0}^{min(L, K_prime)} C(L, m)
    %% P_arr[L] for L=0 to N-1 (max L is N-2, so N-1 is enough)
    P_arr = array:new([{fixed, true}, {size, N}]),

    %% Compute P_arr
    case K_prime < 0 of
        true ->
            lists:foldl(fun(I, Acc) -> array:set(I, 0, P_arr) end, ok, lists:seq(0, N-1));
        false ->
            lists:foldl(fun(L, Acc) ->
                Val = case L =< K_prime of
                          true -> array:get(L, Pow2);
                          false ->
                              CurrentSum = lists:foldl(fun(M, Sum) ->
                                  add(Sum, ncr(L, M, Mod, Facs, InvFacs), Mod)
                              end, 0, lists:seq(0, K_prime)),
                              CurrentSum
                      end,
                array:set(L, Val, P_arr)
            end, ok, lists:seq(0, N-1))
    end,

    %% prefix_sum_P_arr[X] = sum_{L=0}^{X} P_arr[L]
    %% PrefixSumP_arr[X] for X=0 to N-1
    PrefixSumP_arr = array:new([{fixed, true}, {size, N}]),

    lists:foldl(fun(X, Acc) ->
        Val = case X of
                  0 -> array:get(0, P_arr);
                  _ -> add(array:get(X, P_arr), array:get(X-1, PrefixSumP_arr), Mod)
              end,
        array:set(X, Val, PrefixSumP_arr)
    end, ok, lists:seq(0, N-1)),

    TotalSum = lists:foldl(fun(I, AccSum) ->
        NumI = lists:nth(I + 1, SortedNums), 

        Term1 = case N - I - 2 of
                    X when X < 0 -> 0;
                    X -> array:get(X, PrefixSumP_arr)
                end,

        Term2 = case I - 1 of
                    X when X < 0 -> 0;
                    X -> array:get(X, PrefixSumP_arr)
                end,

        Coefficient = add(add(2, Term1, Mod), Term2, Mod),

        add(AccSum, mult(NumI, Coefficient, Mod), Mod)
    end, 0, lists:seq(0, N-1)),

    TotalSum.