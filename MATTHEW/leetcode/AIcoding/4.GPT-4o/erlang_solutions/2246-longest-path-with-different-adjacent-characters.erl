-module(solution).
-export([longestPath/2]).

longestPath/2 ->
    {N, S} = get_input(),
    Nodes = string:to_integer(N),
    Tree = build_tree(S, Nodes),
    longest_path(Tree, <<>>).

get_input() ->
    {io:get_line(""), io:get_line("")}.

build_tree(S, Nodes) ->
    % Build the tree using the string S and the count of Nodes
    % This part will depend on the input format and needs to be implemented accordingly
    [].

longest_path(Tree, Acc) ->
    % Traverse the tree and find the longest path with different adjacent characters
    0.