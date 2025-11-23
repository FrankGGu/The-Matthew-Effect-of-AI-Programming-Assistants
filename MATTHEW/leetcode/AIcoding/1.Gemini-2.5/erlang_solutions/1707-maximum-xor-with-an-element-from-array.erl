-module(solution).
-export([maximizeXor/2]).

maximizeXor(Nums, Queries) ->
    SortedNums = lists:sort(Nums),
    IndexedQueries = lists:zip(lists:seq(0, length(Queries)-1), Queries),
    SortedQueries = lists:sort(fun([{_IdxA, [_XiA, MiA]}, {_IdxB, [_XiB, MiB]}]) -> MiA =< MiB end, IndexedQueries),

    MaxBits = 29,

    process_queries(SortedNums, SortedQueries, MaxBits, #{}, []).

insert_trie(Trie, N, Bit) ->
    if Bit < 0 ->
        Trie;
    true ->
        CurrentBitVal = (N bsr Bit) band 1,
        Child = maps:get(CurrentBitVal, Trie, #{}),
        NewChild = insert_trie(Child, N, Bit-1),
        maps:put(CurrentBitVal, NewChild, Trie)
    end.

query_trie(Trie, X, Bit) ->
    if Bit < 0 ->
        0;
    true ->
        CurrentBitX = (X bsr Bit) band 1,
        DesiredBit = 1 - CurrentBitX,

        if maps:is_key(DesiredBit, Trie) ->
            Child = maps:get(DesiredBit, Trie),
            (1 bsl Bit) bor query_trie(Child, X, Bit-1);
        true ->
            Child = maps:get(CurrentBitX, Trie),
            query_trie(Child, X, Bit-1)
        end
    end.

add_nums_to_trie([Num | RestNums], Mi, Trie, MaxBits) ->
    if Num =< Mi ->
        NewTrie = insert_trie(Trie, Num, MaxBits),
        add_nums_to_trie(RestNums, Mi, NewTrie, MaxBits);
    true ->
        {Trie, [Num | RestNums]}
    end;
add_nums_to_trie([], _Mi, Trie, _MaxBits) ->
    {Trie, []}.

process_queries(NumsList, [{QueryIdx, [Xi, Mi]} | RestQueries], MaxBits, Trie, AccResults) ->
    {NewTrie, RemainingNumsList} = add_nums_to_trie(NumsList, Mi, Trie, MaxBits),

    Result = case NewTrie of
                 #{} -> -1;
                 _ -> query_trie(NewTrie, Xi, MaxBits)
             end,

    process_queries(RemainingNumsList, RestQueries, MaxBits, NewTrie, [{QueryIdx, Result} | AccResults]);
process_queries(_NumsList, [], _MaxBits, _Trie, AccResults) ->
    SortedResults = lists:sort(fun({IdxA, _}, {IdxB, _}) -> IdxA =< IdxB end, AccResults),
    [R || {_, R} <- SortedResults].