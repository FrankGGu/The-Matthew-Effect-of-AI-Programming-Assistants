-module(solution).
-export([number_of_ways/2]).

number_of_ways(N, X) ->
    DP = lists:duplicate(N + 1, 0),
    DP1 = setelement(1, DP, 1),
    number_of_ways_helper(1, N, X, DP1).

number_of_ways_helper(K, N, X, DP) when K > N ->
    element(N + 1, DP);
number_of_ways_helper(K, N, X, DP) ->
    V = pow(K, X),
    if
        V > N ->
            number_of_ways_helper(K + 1, N, X, DP);
        true ->
            NewDP = update_dp(DP, V, N),
            number_of_ways_helper(K + 1, N, X, NewDP)
    end.

update_dp(DP, V, N) ->
    update_dp_helper(N, V, DP, DP).

update_dp_helper(I, V, DP, OriginalDP) when I >= V ->
    Current = element(I + 1, OriginalDP),
    Prev = element(I - V + 1, OriginalDP),
    NewDP = setelement(I + 1, DP, Current + Prev),
    update_dp_helper(I - 1, V, NewDP, OriginalDP);
update_dp_helper(_, _, DP, _) ->
    DP.

pow(Base, Exp) ->
    pow_helper(Base, Exp, 1).

pow_helper(_, 0, Acc) ->
    Acc;
pow_helper(Base, Exp, Acc) ->
    pow_helper(Base, Exp - 1, Acc * Base).