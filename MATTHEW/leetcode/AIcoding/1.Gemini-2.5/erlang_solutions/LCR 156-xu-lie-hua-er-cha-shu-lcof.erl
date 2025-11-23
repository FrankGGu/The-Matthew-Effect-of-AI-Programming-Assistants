-module(codec).
-export([serialize/1, deserialize/1]).

-record(treenode, {val, left, right}).

-spec serialize(treenode() | null) -> string().
serialize(Root) ->
    string_join_iolist(serialize_to_list(Root), ",").

-spec serialize_to_list(treenode() | null) -> [string()].
serialize_to_list(null) ->
    ["null"];
serialize_to_list(#treenode{val=Val, left=Left, right=Right}) ->
    [integer_to_list(Val) | serialize_to_list(Left) ++ serialize_to_list(Right)].

-spec deserialize(string()) -> treenode() | null.
deserialize(Data) ->
    Tokens = string:split(Data, ",", all),
    {Root, _RemainingTokens} = deserialize_helper(Tokens),
    Root.

-spec deserialize_helper([string()]) -> {treenode() | null, [string()]}.
deserialize_helper(["null" | Rest]) ->
    {null, Rest};
deserialize_helper([Token | Rest]) ->
    Val = list_to_integer(Token),
    {Left, RemainingAfterLeft} = deserialize_helper(Rest),
    {Right, RemainingAfterRight} = deserialize_helper(RemainingAfterLeft),
    {#treenode{val=Val, left=Left, right=Right}, RemainingAfterRight}.

-spec string_join_iolist([iolist()], iolist()) -> binary().
string_join_iolist(List, Sep) ->
    iolist_to_binary(do_string_join_iolist(List, Sep)).

-spec do_string_join_iolist([iolist()], iolist()) -> iolist().
do_string_join_iolist([H | T], Sep) ->
    [H | [Sep, E] || E <- T];
do_string_join_iolist([], _Sep) ->
    [].