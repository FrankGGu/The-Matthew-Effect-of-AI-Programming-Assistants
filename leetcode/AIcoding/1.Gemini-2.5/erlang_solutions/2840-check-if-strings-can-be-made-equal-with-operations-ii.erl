-module(solution).
-export([checkStrings/2]).

checkStrings(S1, S2) ->
    N = length(S1),
    {S1_even, S1_odd} = split_by_parity(S1, N),
    {S2_even, S2_odd} = split_by_parity(S2, N),

    lists:sort(S1_even) == lists:sort(S2_even) andalso
    lists:sort(S1_odd) == lists:sort(S2_odd).

split_by_parity(Str, _N) ->
    split_by_parity_recursive(Str, 0, [], []).

split_by_parity_recursive([], _Idx, EvenAcc, OddAcc) ->
    {lists:reverse(EvenAcc), lists:reverse(OddAcc)};
split_by_parity_recursive([H|T], Idx, EvenAcc, OddAcc) ->
    case Idx rem 2 of
        0 ->
            split_by_parity_recursive(T, Idx + 1, [H|EvenAcc], OddAcc);
        1 ->
            split_by_parity_recursive(T, Idx + 1, EvenAcc, [H|OddAcc])
    end.