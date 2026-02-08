-spec alien_order(Words :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
alien_order(Words) ->
    case Words of
        [] -> <<>>;
        [Word] -> binary:part(Word, 0, byte_size(Word));
        _ ->
            Graph = build_graph(Words),
            case is_valid(Graph) of
                false -> <<>>;
                true ->
                    InDegree = calculate_in_degree(Graph),
                    Sorted = topological_sort(Graph, InDegree),
                    case Sorted of
                        [] -> <<>>;
                        _ -> list_to_binary(Sorted)
                    end
            end
    end.

build_graph(Words) ->
    build_graph(Words, #{}).

build_graph([], Graph) -> Graph;
build_graph([_], Graph) -> Graph;
build_graph([Word1, Word2 | Rest], Graph) ->
    case compare_words(Word1, Word2, Graph) of
        {ok, NewGraph} -> build_graph([Word2 | Rest], NewGraph);
        {error, _} -> #{}
    end.

compare_words(Word1, Word2, Graph) ->
    compare_words(Word1, Word2, 0, 0, Graph).

compare_words(Word1, Word2, I, J, Graph) ->
    Len1 = byte_size(Word1),
    Len2 = byte_size(Word2),
    if
        I < Len1 andalso J < Len2 ->
            C1 = binary:at(Word1, I),
            C2 = binary:at(Word2, J),
            if
                C1 =:= C2 -> compare_words(Word1, Word2, I + 1, J + 1, Graph);
                true ->
                    case maps:get(C1, Graph, []) of
                        Edges ->
                            case lists:member(C2, Edges) of
                                true -> {ok, maps:put(C1, [C2 | Edges], Graph)};
                                false -> {ok, maps:put(C1, [C2 | Edges], Graph)}
                            end
                    end
            end;
        Len1 > Len2 -> {error, invalid};
        true -> {ok, Graph}
    end.

is_valid(Graph) ->
    maps:size(Graph) =/= 0.

calculate_in_degree(Graph) ->
    maps:fold(fun(From, Edges, Acc) ->
        lists:foldl(fun(To, InDeg) ->
            maps:update_with(To, fun(V) -> V + 1 end, 1, InDeg)
        end, Acc, Edges)
    end, #{}, Graph).

topological_sort(Graph, InDegree) ->
    ZeroInDegree = [C || {C, 0} <- maps:to_list(InDegree)],
    topological_sort(Graph, InDegree, ZeroInDegree, []).

topological_sort(_Graph, _InDegree, [], Result) ->
    case maps:size(_InDegree) =:= length(Result) of
        true -> lists:reverse(Result);
        false -> []
    end;
topological_sort(Graph, InDegree, [C | Queue], Result) ->
    Edges = maps:get(C, Graph, []),
    {NewInDegree, NewQueue} = lists:foldl(fun(To, {InDeg, Q}) ->
        case maps:get(To, InDeg) - 1 of
            0 -> {maps:remove(To, InDeg), [To | Q]};
            N -> {maps:put(To, N, InDeg), Q}
        end
    end, {InDegree, Queue}, Edges),
    topological_sort(Graph, NewInDegree, NewQueue, [C | Result]).