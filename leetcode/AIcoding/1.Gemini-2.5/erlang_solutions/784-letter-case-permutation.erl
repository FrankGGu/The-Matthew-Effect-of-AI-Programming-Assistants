-module(solution).
-export([letter_case_permutation/1]).

letter_case_permutation(S) ->
    solve(S).

solve([]) ->
    [[]];
solve([H | T]) ->
    RestPerms = solve(T),
    if
        H >= $0 andalso H =< $9 ->
            [ [H | P] || P <- RestPerms ];
        true ->
            LowerH = erlang:to_lower(H),
            UpperH = erlang:to_upper(H),
            Perms1 = [ [LowerH | P] || P <- RestPerms ],
            Perms2 = [ [UpperH | P] || P <- RestPerms ],
            Perms1 ++ Perms2
    end.