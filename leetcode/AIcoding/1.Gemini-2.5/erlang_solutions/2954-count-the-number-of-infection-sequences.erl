-module(solution).
-export([number_of_sequences/2]).

-define(MOD, 1000000007).
-define(MAX_N, 100000).

-persistent_term:put(fact_table, make_fact_table(?MAX_N)).
-persistent_term:put(inv_fact_table, make_inv_fact_table(?MAX_N)).

make_fact_table(N) ->
    Table = array:new([{size, N + 1}, {fixed, true}]),
    Table1 = array:set(0, 1, Table),
    lists:foldl(fun(I, Acc) ->
        array:set(I, (array:get(I-1, Acc) * I) rem ?MOD, Acc)
    end, Table1, lists:seq(1, N)).

make_inv_fact_table(N) ->
    FactTable = ?persistent_term:get(fact_table),
    InvFactN = pow(array:get(N, FactTable), ?MOD - 2, ?MOD),
    Table = array:new([{size, N + 1}, {fixed, true}]),
    TableN = array:set(N, InvFactN, Table),
    lists:foldl(fun(I, Acc) ->
        array:set(I-1, (array:get(I, Acc) * I) rem ?MOD, Acc)
    end, TableN, lists:seq(N, 1, -1)).

get_fact(N) ->
    array:get(N, ?persistent_term:get(fact_table)).

get_inv_fact(N) ->
    array:get(N, ?persistent_term:get(inv_fact_table)).

pow(Base, Exp, Mod) ->
    pow_acc(Base, Exp, Mod, 1).

pow_acc(_, 0, _, Acc) -> Acc;
pow_acc(Base, Exp, Mod, Acc) ->
    case Exp rem 2 of
        1 -> pow_acc((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
        _ -> pow_acc((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.

number_of_sequences(N, Infected) ->
    SortedInfected = lists:sort(Infected),
    K = length(SortedInfected),

    TotalUninfected = N - K,

    %% Initialize answer with (TotalUninfected)!
    Ans = get_fact(TotalUninfected),

    %% Calculate factor for the leftmost gap
    LeftGapLen = hd(SortedInfected),
    CurrentAns1 = (Ans * get_inv_fact(LeftGapLen)) rem ?MOD,

    %% Calculate factor for the rightmost gap
    RightGapLen = N - 1 - lists:last(SortedInfected),
    CurrentAns2 = (CurrentAns1 * get_inv_fact(RightGapLen)) rem ?MOD,

    %% Iterate through middle gaps to apply their factors
    {FinalAns, _} = lists:foldl(fun(CurrentInfected, {AccAns, PrevInfected}) ->
        GapLen = CurrentInfected - PrevInfected - 1,
        NewAccAns = (AccAns * get_inv_fact(GapLen)) rem ?MOD,
        WeightedAccAns = case GapLen > 0 of
                             true -> (NewAccAns * pow(2, GapLen, ?MOD)) rem ?MOD;
                             false -> NewAccAns
                         end,
        {WeightedAccAns, CurrentInfected}
    end, {CurrentAns2, hd(SortedInfected)}, tl(SortedInfected)),

    FinalAns.