-module(solution).
-export([findLadders/3]).

replace_char_at_index(Word, Idx, NewChar) ->
    {Prefix, Suffix} = lists:splitat(Idx, Word),
    Prefix ++ [NewChar] ++ tl(Suffix).

generate_neighbors(Word, WordSet) ->
    WordLen = length(Word),
    Chars = [$a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r, $s, $t, $u, $v, $w, $x, $y, $z],
    lists:foldl(
        fun(Idx, Acc) ->
            lists:foldl(
                fun(C, Acc2) ->
                    NewWord = replace_char_at_index(Word, Idx, C),
                    case NewWord == Word of
                        true -> Acc2;
                        false ->
                            case sets:is_element(NewWord, WordSet) of
                                true -> [NewWord | Acc2];
                                false -> Acc2
                            end
                    end
                end,
                Acc,
                Chars
            )
        end,
        [],
        lists:seq(0, WordLen - 1)
    ).

findLadders(BeginWord, EndWord, WordList) ->
    case BeginWord == EndWord of
        true ->
            [[BeginWord]];
        false ->
            InitialWordSet = sets:from_list(WordList),
            case sets:is_element(EndWord, InitialWordSet) of
                false ->
                    [];
                true ->
                    Q = queue:in({BeginWord, 0}, queue:new()),
                    Distances = maps:put(BeginWord, 0, maps:new()),
                    Predecessors = maps:new(),
                    MinLength = 1_000_000_000,

                    {FinalPredecessors, FinalMinLength} = bfs_phase1(Q, Distances, Predecessors, InitialWordSet, MinLength, EndWord),

                    case FinalMinLength == 1_000_000_000 of
                        true -> [];
                        false ->
                            dfs_phase2(EndWord, BeginWord, FinalPredecessors, [], [])
                    end
            end
    end.

bfs_phase1(Q, Distances, Predecessors, WordSet, MinLength, EndWord) ->
    case queue:is_empty(Q) of
        true ->
            {Predecessors, MinLength};
        false ->
            {{value, {CurrentWord, CurrentDist}}, Q2} = queue:out(Q),

            case CurrentDist > MinLength of
                true ->
                    bfs_phase1(Q2, Distances, Predecessors, WordSet, MinLength, EndWord);
                false ->
                    NewMinLength = case CurrentWord == EndWord of
                                       true -> min(MinLength, CurrentDist);
                                       false -> MinLength
                                   end,

                    case CurrentDist + 1 > NewMinLength of
                        true ->
                            bfs_phase1(Q2, Distances, Predecessors, WordSet, NewMinLength, EndWord);
                        false ->
                            Neighbors = generate_neighbors(CurrentWord, WordSet),

                            {NewQ, NewDistances, NewPredecessors} = lists:foldl(
                                fun(Neighbor, {AccQ, AccDistances, AccPredecessors}) ->
                                    case maps:is_key(Neighbor, AccDistances) of
                                        true ->
                                            NeighborDist = maps:get(Neighbor, AccDistances),
                                            case NeighborDist == CurrentDist + 1 of
                                                true ->
                                                    UpdatedPredecessors = maps:update_with(Neighbor, fun(L) -> [CurrentWord | L] end, [CurrentWord], AccPredecessors),
                                                    {AccQ, AccDistances, UpdatedPredecessors};
                                                false ->
                                                    {AccQ, AccDistances, AccPredecessors}
                                            end;
                                        false ->
                                            UpdatedDistances = maps:put(Neighbor, CurrentDist + 1, AccDistances),
                                            UpdatedPredecessors = maps:put(Neighbor, [CurrentWord], AccPredecessors),
                                            UpdatedQ = queue:in({Neighbor, CurrentDist + 1}, AccQ),
                                            {UpdatedQ, UpdatedDistances, UpdatedPredecessors}
                                    end
                                end,
                                {Q2, Distances, Predecessors},
                                Neighbors
                            ),
                            bfs_phase1(NewQ, NewDistances, NewPredecessors, WordSet, NewMinLength, EndWord)
                    end
            end
    end.

dfs_phase2(CurrentWord, BeginWord, Predecessors, CurrentPath, AllPaths) ->
    Path = [CurrentWord | CurrentPath],
    case CurrentWord == BeginWord of
        true ->
            [Path | AllPaths];
        false ->
            case maps:is_key(CurrentWord, Predecessors) of
                true ->
                    ParentWords = maps:get(CurrentWord, Predecessors),
                    lists:foldl(
                        fun(ParentWord, AccAllPaths) ->
                            dfs_phase2(ParentWord, BeginWord, Predecessors, Path, AccAllPaths)
                        end,
                        AllPaths,
                        ParentWords
                    );
                false ->
                    AllPaths
            end
    end.