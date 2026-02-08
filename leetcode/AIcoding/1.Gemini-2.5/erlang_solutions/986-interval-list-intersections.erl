-module(solution).
-export([interval_list_intersections/2]).

-spec interval_list_intersections(FirstList :: [[integer()]], SecondList :: [[integer()]]) -> [[integer()]].
interval_list_intersections(FirstList, SecondList) ->
    solve(FirstList, SecondList, []).

solve([], _B, Acc) -> lists:reverse(Acc);
solve(_A, [], Acc) -> lists:reverse(Acc);
solve([[A_start, A_end] | RestA], [[B_start, B_end] | RestB], Acc) ->
    Low = max(A_start, B_start),
    High = min(A_end, B_end),

    NewAcc = 
        if Low =< High -> [[Low, High] | Acc];
           true -> Acc
        end,

    if A_end < B_end ->
        solve(RestA, [[B_start, B_end] | RestB], NewAcc);
    true -> % B_end >= A_end
        solve([[A_start, A_end] | RestA], RestB, NewAcc)
    end.