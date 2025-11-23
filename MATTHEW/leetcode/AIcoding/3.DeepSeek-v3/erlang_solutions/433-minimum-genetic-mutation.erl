-module(solution).
-export([min_mutation/3]).

min_mutation(Start, End, Bank) ->
    case lists:member(End, Bank) of
        false -> -1;
        true ->
            Queue = [{Start, 0}],
            Visited = sets:from_list([Start]),
            bfs(Queue, Visited, End, Bank)
    end.

bfs([], _, _, _) -> -1;
bfs([{Current, Steps} | Rest], Visited, End, Bank) ->
    case Current =:= End of
        true -> Steps;
        false ->
            Mutations = generate_mutations(Current, Bank),
            NewQueue = lists:foldl(fun(Next, Acc) ->
                case sets:is_element(Next, Visited) of
                    false -> [{Next, Steps + 1} | Acc];
                    true -> Acc
                end
            end, Rest, Mutations),
            NewVisited = lists:foldl(fun(Next, Acc) ->
                sets:add_element(Next, Acc)
            end, Visited, Mutations),
            bfs(NewQueue, NewVisited, End, Bank)
    end.

generate_mutations(Gene, Bank) ->
    lists:filter(fun(Mutation) ->
        is_valid_mutation(Gene, Mutation) andalso lists:member(Mutation, Bank)
    end, possible_mutations(Gene)).

possible_mutations(Gene) ->
    Chars = "ACGT",
    lists:foldl(fun(I, Acc) ->
        Prefix = string:substr(Gene, 1, I - 1),
        Suffix = string:substr(Gene, I + 1),
        lists:foldl(fun(C, Acc2) ->
            [Prefix ++ [C] ++ Suffix | Acc2]
        end, Acc, Chars)
    end, [], lists:seq(1, length(Gene))).

is_valid_mutation(Gene1, Gene2) ->
    lists:sum(lists:zipwith(fun(C1, C2) -> if C1 =:= C2 -> 0; true -> 1 end end, Gene1, Gene2)) =:= 1.