-module(rle_iterator).
-export([init/1, next/2]).

init(A) ->
    {A, 0}.

next([], _N) ->
    -1;
next([Count, Val | Rest], N) when N =< Count ->
    {[Count - N, Val | Rest], Val};
next([Count, _Val | Rest], N) ->
    next(Rest, N - Count).