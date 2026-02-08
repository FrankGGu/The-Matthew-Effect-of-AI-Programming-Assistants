-module(solution).
-export([solve/2]).

solve(Moles, D) ->
    SortedMoles = lists:sort(fun({T1, _}, {T2, _}) -> T1 =< T2 end, Moles),
    DPs = dp_values_helper(SortedMoles, D, [], []),
    case DPs of
        [] -> 0;
        _ -> lists:max(DPs)
    end.

dp_values_helper([], _, _, AccDPs) ->
    lists:reverse(AccDPs);
dp_values_helper([CurrentMole | RestMoles], D, PreviousMolesWithDPs, AccDPs) ->
    {CurrentT, CurrentX} = CurrentMole,

    BaseDP = if abs(CurrentX) =< D * CurrentT -> 1; else 0 end,

    CurrentDP = lists:foldl(fun({PrevT, PrevX, PrevDP}, MaxSoFar) ->
                                if PrevDP > 0 andalso abs(CurrentX - PrevX) =< D * (CurrentT - PrevT) ->
                                    max(MaxSoFar, PrevDP + 1);
                                else
                                    MaxSoFar
                                end
                            end, BaseDP, PreviousMolesWithDPs),

    dp_values_helper(RestMoles, D, [{CurrentT, CurrentX, CurrentDP} | PreviousMolesWithDPs], [CurrentDP | AccDPs]).