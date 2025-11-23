-module(solution).
-export([find_lexicographically_smallest_valid_sequence/1]).

find_lexicographically_smallest_valid_sequence(Nums) ->
    N = length(Nums),
    find_lexicographically_smallest_valid_sequence(Nums, 0, [], []).

find_lexicographically_smallest_valid_sequence(_, _, _, []) ->
    [];
find_lexicographically_smallest_valid_sequence(Nums, Start, Path, [H | T]) ->
    case lists:member(H, Path) of
        true ->
            find_lexicographically_smallest_valid_sequence(Nums, Start, Path, T);
        false ->
            NewPath = Path ++ [H],
            if
                length(NewPath) == length(Nums) ->
                    NewPath;
                true ->
                    NextStart = lists:nthindex(H, Nums) + 1,
                    Result = find_lexicographically_smallest_valid_sequence(Nums, NextStart, NewPath, lists:seq(1, length(Nums))),
                    if
                        Result /= [] ->
                            Result;
                        true ->
                            find_lexicographically_smallest_valid_sequence(Nums, Start, Path, T)
                    end
            end
    end.

lists:nthindex(Item, List) ->
    lists:nthindex(Item, List, 1).

lists:nthindex(Item, [Item | _], Index) ->
    Index - 1;
lists:nthindex(Item, [_ | Tail], Index) ->
    lists:nthindex(Item, Tail, Index + 1);
lists:nthindex(_, [], _) ->
    -1.