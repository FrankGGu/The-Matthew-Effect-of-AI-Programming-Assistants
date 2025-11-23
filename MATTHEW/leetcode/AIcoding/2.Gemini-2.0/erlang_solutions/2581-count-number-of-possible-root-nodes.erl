-module(solution).
-export([count_possible_root_nodes/2]).

count_possible_root_nodes(N, Edges, Guesses) ->
    graph_to_adjacency_list(N, Edges, Adj),
    guesses_to_set(Guesses, GuessesSet),
    dfs(1, 0, -1, Adj, GuessesSet, 0).

graph_to_adjacency_list(N, Edges, Adj) ->
    lists:foldl(fun({U, V}, Acc) ->
                        Acc#{U => lists:sort([V | maps:get(U, Acc, [])]),
                              V => lists:sort([U | maps:get(V, Acc, [])])}
                end, maps:new(), Edges).

guesses_to_set(Guesses, GuessesSet) ->
    lists:foldl(fun({U, V}, Acc) ->
                        sets:add({U, V}, Acc)
                end, sets:new(), Guesses).

dfs(Node, Correct, Parent, Adj, GuessesSet, Count) ->
    Correct1 = case sets:is_element({Parent, Node}, GuessesSet) of
                   true -> Correct - 1;
                   false -> Correct
               end,
    Children = lists:filter(fun(Child) -> Child /= Parent end, maps:get(Node, Adj, [])),
    NewCorrect = lists:foldl(fun(Child, Acc) ->
                                   case sets:is_element({Node, Child}, GuessesSet) of
                                       true -> Acc + 1;
                                       false -> Acc
                                   end
                               end, Correct1, Children),
    lists:foldl(fun(Child, Acc) ->
                        dfs(Child, NewCorrect, Node, Adj, GuessesSet, Acc)
                end,
                case NewCorrect >= 0 of
                    true -> Count + 1;
                    false -> Count
                end,
                Children).