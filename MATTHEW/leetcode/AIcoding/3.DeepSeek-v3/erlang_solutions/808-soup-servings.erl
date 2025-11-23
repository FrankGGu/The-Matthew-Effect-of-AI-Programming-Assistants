-module(solution).
-export([soupServings/1]).

soupServings(N) ->
    if 
        N >= 5000 -> 1.0;
        true -> 
            M = (N + 24) div 25,
            Memo = maps:new(),
            {Result, _} = dp(M, M, Memo),
            Result
    end.

dp(0, 0, Memo) -> {0.5, Memo};
dp(0, _, Memo) -> {1.0, Memo};
dp(_, 0, Memo) -> {0.0, Memo};
dp(A, B, Memo) ->
    case maps:find({A, B}, Memo) of
        {ok, Val} -> {Val, Memo};
        error ->
            {P1, Memo1} = dp(max(A - 4, 0), B, Memo),
            {P2, Memo2} = dp(max(A - 3, 0), max(B - 1, 0), Memo1),
            {P3, Memo3} = dp(max(A - 2, 0), max(B - 2, 0), Memo2),
            {P4, Memo4} = dp(max(A - 1, 0), max(B - 3, 0), Memo3),
            Val = (P1 + P2 + P3 + P4) / 4.0,
            {Val, maps:put({A, B}, Val, Memo4)}
    end.