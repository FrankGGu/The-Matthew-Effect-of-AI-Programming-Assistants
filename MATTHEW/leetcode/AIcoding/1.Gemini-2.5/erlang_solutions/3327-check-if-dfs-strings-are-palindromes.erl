-module(solution).
-export([check_dfs_strings_are_palindromes/2]).

is_palindrome(Str) ->
    Str == lists:reverse(Str).

dfs(CurrentNode, CurrentPathChars, Visited, Graph, NodeChars) ->
    Char = maps:get(CurrentNode, NodeChars),
    NewPathChars = [Char | CurrentPathChars],
    NewVisited = sets:add_element(CurrentNode, Visited),

    PathString = lists:reverse(NewPathChars),
    IsPalindrome = is_palindrome(PathString),

    if IsPalindrome ->
        true;
    true ->
        Neighbors = maps:get(CurrentNode, Graph, []),
        lists:any(fun(Neighbor) ->
            if not sets:is_element(Neighbor, NewVisited) ->
                dfs(Neighbor, NewPathChars, NewVisited, Graph, NodeChars);
            true ->
                false
            end
        end, Neighbors)
    end.

check_dfs_strings_are_palindromes(Graph, NodeChars) ->
    Nodes = maps:keys(Graph),
    lists:any(fun(StartNode) ->
        dfs(StartNode, [], sets:new(), Graph, NodeChars)
    end, Nodes).