-module(max_genetic_diff).
-export([getMaximumGeneticDifference/2]).

getMaximumGeneticDifference(Queries, Genomes) ->
    getMaximumGeneticDifference(Queries, Genomes, 0, 1 << 20, []).

getMaximumGeneticDifference([], _, _, _, Acc) ->
    lists:reverse(Acc);
getMaximumGeneticDifference([Query | Rest], Genomes, Level, Mask, Acc) ->
    {Id, Num} = Query,
    Trie = build_trie(Genomes),
    Max = find_max_xor(Trie, Num),
    getMaximumGeneticDifference(Rest, Genomes, Level + 1, Mask, [Max | Acc]).

build_trie(Genomes) ->
    build_trie(Genomes, #{}).

build_trie([], Trie) ->
    Trie;
build_trie([Num | Rest], Trie) ->
    build_trie(Rest, insert_into_trie(Trie, Num)).

insert_into_trie(Trie, Num) ->
    insert_into_trie(Trie, Num, 30, 0).

insert_into_trie(Trie, Num, Level, Bit) when Level >= 0 ->
    CurrentBit = (Num bsr Level) band 1,
    Child = case maps:get(CurrentBit, Trie, #{}) of
        Child when is_map(Child) -> Child;
        _ -> #{}
    end,
    NewChild = insert_into_trie(Child, Num, Level - 1, Bit),
    maps:put(CurrentBit, NewChild, Trie);
insert_into_trie(Trie, _, _, _) ->
    Trie.

find_max_xor(Trie, Num) ->
    find_max_xor(Trie, Num, 30, 0).

find_max_xor(_, _, Level, Result) when Level < 0 ->
    Result;
find_max_xor(Trie, Num, Level, Result) ->
    CurrentBit = (Num bsr Level) band 1,
    OppositeBit = 1 - CurrentBit,
    case maps:is_key(OppositeBit, Trie) of
        true ->
            find_max_xor(maps:get(OppositeBit, Trie), Num, Level - 1, Result bor (1 bsl Level));
        false ->
            find_max_xor(maps:get(CurrentBit, Trie, #{}), Num, Level - 1, Result)
    end.