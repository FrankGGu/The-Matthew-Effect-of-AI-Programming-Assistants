-module(rle_iterator).
-export([init/1, next/2]).

init(Encoded) ->
    Encoded.

next(N, []) ->
    {-1, []};
next(N, [Count, Value | Rest]) when Count >= N ->
    NewCount = Count - N,
    NewState = if NewCount == 0 -> Rest;
               true -> [NewCount, Value | Rest]
            end,
    {Value, NewState};
next(N, [Count, _Value | Rest]) when Count < N ->
    next(N - Count, Rest).