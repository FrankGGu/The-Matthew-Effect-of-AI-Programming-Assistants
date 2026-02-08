-module(solution).
-export([sumSubseqWidths/1]).

sumSubseqWidths(A) ->
    SortedA = lists:sort(A),
    N = length(SortedA),
    Mod = 1000000007,

    PowersOf2 = precompute_powers(N, Mod),

    ReversedPowersOf2 = lists:reverse(PowersOf2),

    CombinedList = combine_lists(SortedA, PowersOf2, ReversedPowersOf2),

    lists:foldl(
        fun({Element, PowerI, PowerNMinus1MinusI}, AccSum) ->
            Term = (Element * PowerI - Element * PowerNMinus1MinusI) rem Mod,
            (AccSum + Term + Mod) rem Mod
        end,
        0,
        CombinedList
    ).

precompute_powers(N, Mod) ->
    precompute_powers_recursive(N, Mod, 1, []).

precompute_powers_recursive(0, _Mod, _CurrentPower, Acc) ->
    lists:reverse(Acc);
precompute_powers_recursive(N, Mod, CurrentPower, Acc) ->
    precompute_powers_recursive(N - 1, Mod, (CurrentPower * 2) rem Mod, [CurrentPower | Acc]).

combine_lists(L1, L2, L3) ->
    combine_lists_recursive(L1, L2, L3, []).

combine_lists_recursive([], [], [], Acc) ->
    lists:reverse(Acc);
combine_lists_recursive([H1|T1], [H2|T2], [H3|T3], Acc) ->
    combine_lists_recursive(T1, T2, T3, [{H1, H2, H3} | Acc]).