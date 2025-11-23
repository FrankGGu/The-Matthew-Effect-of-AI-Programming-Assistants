-module(word_ladder_ii).
-export([find_ladders/3]).

find_ladders(StartWord, EndWord, WordList) ->
    WordSet = sets:from_list(WordList),
    case sets:is_element(EndWord, WordSet) of
        false -> [];
        true ->
            Map = build_ladder_map(StartWord, WordSet),
            find_ladders_helper(StartWord, EndWord, WordSet, Map, [])
    end.

build_ladder_map(StartWord, WordSet) ->
    build_ladder_map(StartWord, WordSet, dict:new(), 0).

build_ladder_map(_, _, _, _) -> dict:new();
build_ladder_map(StartWord, WordSet, Map, Level) ->
    NextWords = get_next_words(StartWord, WordSet),
    case NextWords of
        [] -> Map;
        _ ->
            NewMap = lists:foldl(fun(W, Acc) -> dict:store(W, Level + 1, Acc) end, Map, NextWords),
            lists:foldl(fun(W, Acc) -> build_ladder_map(W, WordSet, Acc, Level + 1) end, NewMap, NextWords)
    end.

get_next_words(Word, WordSet) ->
    Words = lists:map(fun(I) -> replace_char(Word, I, $*) end, lists:seq(0, length(Word) - 1)),
    lists:filter(fun(W) -> sets:is_element(W, WordSet) end, Words).

replace_char(Str, Index, Char) ->
    lists:sublist(Str, Index) ++ [Char] ++ lists:sublist(Str, Index + 1, length(Str) - Index).

find_ladders_helper(StartWord, EndWord, WordSet, Map, Paths) ->
    find_ladders_helper(StartWord, EndWord, WordSet, Map, [], [[StartWord]]).

find_ladders_helper(_, EndWord, _, _, _, Paths) when not lists:member(EndWord, lists:last(Paths)) -> Paths;
find_ladders_helper(Current, EndWord, WordSet, Map, Visited, Paths) ->
    case Current of
        EndWord -> Paths;
        _ ->
            NextWords = get_next_words(Current, WordSet),
            ValidNextWords = lists:filter(fun(W) -> dict:is_key(W, Map) andalso dict:fetch(W, Map) == dict:fetch(Current, Map) + 1 end, NextWords),
            NewPaths = lists:foldl(fun(W, Acc) -> add_path(Acc, W, Current) end, Paths, ValidNextWords),
            find_ladders_helper(EndWord, EndWord, WordSet, Map, [Current | Visited], NewPaths)
    end.

add_path(Paths, NextWord, Current) ->
    lists:foldl(fun(P, Acc) ->
                    case lists:last(P) of
                        Current -> Acc ++ [P ++ [NextWord]];
                        _ -> Acc
                    end
                end, Paths, Paths).