-module(solve).
-export([serialize/1, deserialize/1]).

-define(NULL, null).

serialize(nil) -> [?NULL];
serialize(#btree{val = Val, left = Left, right = Right}) ->
    [Val | [serialize(Left), serialize(Right)]].

deserialize([]) -> nil;
deserialize([?NULL | Rest]) -> {nil, Rest};
deserialize([Val | Rest]) ->
    {Left, Rest1} = deserialize(Rest),
    {Right, Rest2} = deserialize(Rest1),
    {#btree{val = Val, left = Left, right = Right}, Rest2}.

-record(btree, {val, left, right}).