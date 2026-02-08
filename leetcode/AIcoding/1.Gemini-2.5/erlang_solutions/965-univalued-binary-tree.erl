-module(solution).
-export([is_unival_tree/1]).

is_unival_tree(nil) ->
    true;
is_unival_tree({Val, Left, Right}) ->
    check_unival_tree({Val, Left, Right}, Val).

check_unival_tree(nil, _) ->
    true;
check_unival_tree({Val, Left, Right}, ExpectedVal) ->
    Val == ExpectedVal andalso
    check_unival_tree(Left, ExpectedVal) andalso
    check_unival_tree(Right, ExpectedVal).