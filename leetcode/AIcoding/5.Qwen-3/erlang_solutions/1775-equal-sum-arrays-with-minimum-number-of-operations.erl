-module(equalequal).
-export([min_operations/2]).

min_operations(S, T) ->
    SumS = lists:sum(S),
    SumT = lists:sum(T),
    if
        SumS == SumT -> 0;
        true -> 
            case SumS > SumT of
                true -> 
                    S_sorted = lists:reverse(lists:sort(S)),
                    T_sorted = lists:sort(T),
                    do_min_operations(S_sorted, T_sorted, 0, SumS, SumT);
                false -> 
                    S_sorted = lists:sort(S),
                    T_sorted = lists:reverse(lists:sort(T)),
                    do_min_operations(S_sorted, T_sorted, 0, SumS, SumT)
            end
    end.

do_min_operations([], _, Ops, _, _) -> Ops;
do_min_operations(_, [], Ops, _, _) -> Ops;
do_min_operations([SVal | SRest], [TVal | TRest], Ops, SumS, SumT) ->
    if
        SumS == SumT -> Ops;
        true ->
            Delta = abs(SumS - SumT),
            if
                SVal > TVal ->
                    NewSumS = SumS - SVal,
                    NewSumT = SumT + TVal,
                    do_min_operations(SRest, TRest, Ops + 1, NewSumS, NewSumT);
                true ->
                    NewSumS = SumS + SVal,
                    NewSumT = SumT - TVal,
                    do_min_operations(SRest, TRest, Ops + 1, NewSumS, NewSumT)
            end
    end.