-module(solution).
-export([minimum_score/3]).

minimum_score(A, B, C) ->
    {MinA, MaxA} = lists:foldl(fun(X, {Min, Max}) ->
        {min(Min, X), max(Max, X)}
    end, {infinity, -infinity}, A),
    {MinB, MaxB} = lists:foldl(fun(X, {Min, Max}) ->
        {min(Min, X), max(Max, X)}
    end, {infinity, -infinity}, B),
    {MinC, MaxC} = lists:foldl(fun(X, {Min, Max}) ->
        {min(Min, X), max(Max, X)}
    end, {infinity, -infinity}, C),
    MaxA - MinB + MaxB - MinC + MaxC - MinA.