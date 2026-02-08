-module(serialize_deserialize_bst).
-export([serialize/1, deserialize/1]).

-include_lib("eunit/include/eunit.hrl").

-record(bst_node, {val, left, right}).

serialize(nil) ->
    [];
serialize(#bst_node{val = Val, left = Left, right = Right}) ->
    [integer_to_list(Val) | ["," | serialize(Left) ++ ["," | serialize(Right)]]].

deserialize([]) ->
    nil;
deserialize(S) ->
    {Tree, _} = parse_tree(S, 0),
    Tree.

parse_tree([], _) ->
    {nil, 0};
parse_tree(S, Pos) ->
    case get_next_token(S, Pos) of
        {Token, NewPos} when Token == "nil" ->
            {nil, NewPos};
        {Token, NewPos} ->
            Val = list_to_integer(Token),
            {Left, NewPos1} = parse_tree(S, NewPos),
            {Right, NewPos2} = parse_tree(S, NewPos1),
            {{#bst_node{val = Val, left = Left, right = Right}, NewPos2}
        end.

get_next_token([], _) ->
    {"nil", 0};
get_next_token(S, Pos) ->
    case string:chr(S, Pos + 1, $,) of
        nomatch ->
            {string:substr(S, Pos + 1), length(S)};
        {match, CommaPos} ->
            {string:substr(S, Pos + 1, CommaPos - Pos - 1), CommaPos}
    end.