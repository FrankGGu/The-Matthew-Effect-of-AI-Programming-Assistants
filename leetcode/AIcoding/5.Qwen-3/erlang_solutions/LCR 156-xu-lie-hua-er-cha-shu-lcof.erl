-module(serialize_and_deserialize_binary_tree).
-export([serialize/1, deserialize/1]).

-record(btree, {val, left, right}).

serialize(nil) ->
    "null";
serialize(#btree{val=Val, left=Left, right=Right}) ->
    [integer_to_list(Val), ",", serialize(Left), ",", serialize(Right)].

deserialize(S) ->
    deserialize(lists:split(1, S)).

deserialize({[], _}) ->
    nil;
deserialize({[H | T], Rest}) when H == $n ->
    {_, Rest1} = lists:split(4, Rest),
    deserialize({lists:tl(T), Rest1});
deserialize({[H | T], Rest}) when H == $, ->
    deserialize({T, Rest});
deserialize({[H | T], Rest}) ->
    {Val, Rest1} = parse_number(H, T),
    Left = deserialize({[], Rest1}),
    Right = deserialize({[], Rest1}),
    {#btree{val=Val, left=Left, right=Right}, Rest1}.

parse_number(Digit, []) ->
    {Digit - $0, []};
parse_number(Digit, [Next | Rest]) when Next >= $0, Next =< $9 ->
    parse_number(Digit * 10 + (Next - $0), Rest);
parse_number(Digit, _) ->
    {Digit - $0, []}.