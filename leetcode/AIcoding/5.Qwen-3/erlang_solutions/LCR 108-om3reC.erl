-module(word_ladder).
-export([ladder_length/2]).

ladder_length(StartWord, WordList) ->
    WordSet = sets:from_list(WordList),
    if
        not sets:is_element(StartWord, WordSet) -> 0;
        true -> bfs(StartWord, WordSet, 1, sets:new())
    end.

bfs(_, _, _, _) -> 0;
bfs(Current, WordSet, Steps, Visited) ->
    case sets:is_element(Current, Visited) of
        true -> 0;
        false ->
            NewVisited = sets:add_element(Current, Visited),
            case sets:is_element(Current, WordSet) of
                true ->
                    case Current of
                        "end" -> Steps;
                        _ ->
                            Neighbors = generate_neighbors(Current),
                            Results = [bfs(Neighbor, WordSet, Steps + 1, NewVisited) || Neighbor <- Neighbors],
                            lists:foldl(fun(A, B) when A > 0 -> A; (_, B) -> B end, 0, Results)
                    end;
                false -> 0
            end
    end.

generate_neighbors(Str) ->
    generate_neighbors(Str, 0, []).

generate_neighbors(_, Len, Acc) when Len >= erlang:length(Str) -> Acc;
generate_neighbors(Str, Pos, Acc) ->
    Char = erlang:element(Pos + 1, Str),
    List = erlang:list_to_tuple(lists:seq($a, $z)),
    Neighbors = [lists:sublist(Str, Pos) ++ [C] ++ lists:sublist(Str, Pos + 1, erlang:length(Str) - Pos - 1) || C <- List],
    generate_neighbors(Str, Pos + 1, Acc ++ Neighbors).