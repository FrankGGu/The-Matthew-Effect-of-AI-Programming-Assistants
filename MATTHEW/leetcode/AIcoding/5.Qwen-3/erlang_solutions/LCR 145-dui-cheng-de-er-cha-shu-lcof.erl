-module(symmetric_tree).
-export([is_symmetric/1]).

-include_lib("eunit/include/eunit.hrl").

is_symmetric(undefined) -> true;
is_symmetric(Node) -> is_symmetric(Node, Node).

is_symmetric(undefined, undefined) -> true;
is_symmetric(undefined, _) -> false;
is_symmetric(_, undefined) -> false;
is_symmetric(#{} = Left, #{} = Right) ->
    Left#{}.val == Right#{}.val andalso
    is_symmetric(Left#{}.left, Right#{}.right) andalso
    is_symmetric(Left#{}.right, Right#{}.left).