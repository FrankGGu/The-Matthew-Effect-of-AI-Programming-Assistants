-module(solution).
-export([main/1]).

main(_) ->
    {ok, [N]} = io:fread("", "~d"),
    Tree = read_tree(N),
    Result = solve(Tree),
    io:format("~p~n", [Result]).

read_tree(0) -> [];
read_tree(N) ->
    {ok, Line} = io:fread("", "~s"),
    [H|T] = string:tokens(Line, " "),
    {list_to_integer(H), read_tree(N-1)}.

solve([]) -> 0;
solve({Val, Children}) ->
    Max = lists:max([0 | [solve(Child) || Child <- Children]]),
    Val + Max.