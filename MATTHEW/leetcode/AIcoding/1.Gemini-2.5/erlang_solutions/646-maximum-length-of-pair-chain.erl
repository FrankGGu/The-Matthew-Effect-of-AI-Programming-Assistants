-module(solution).
-export([find_longest_chain/1]).

find_longest_chain(Pairs) ->
    SortedPairs = lists:sort(fun([_A1, B1], [_A2, B2]) ->
                                     B1 < B2 orelse (B1 == B2 andalso _A1 < _A2)
                             end, Pairs),
    find_longest_chain_helper(SortedPairs, 0, -2000000000).

find_longest_chain_helper([], ChainLength, _PrevEnd) ->
    ChainLength;
find_longest_chain_helper([[Start, End] | Rest], ChainLength, PrevEnd) ->
    if Start > PrevEnd ->
        find_longest_chain_helper(Rest, ChainLength + 1, End);
    true ->
        find_longest_chain_helper(Rest, ChainLength, PrevEnd)
    end.