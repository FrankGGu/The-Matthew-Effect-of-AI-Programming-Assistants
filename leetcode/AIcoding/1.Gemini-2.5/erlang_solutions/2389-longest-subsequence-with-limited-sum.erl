-module(solution).
-export([answerQueries/2]).

answerQueries(Nums, Queries) ->
    SortedNums = lists:sort(Nums),
    PrefixSums = make_prefix_sums(SortedNums),
    lists:map(fun(Q) -> find_length(Q, PrefixSums) end, Queries).

make_prefix_sums(List) ->
    make_prefix_sums(List, 0, []).

make_prefix_sums([H|T], CurrentSum, Acc) ->
    make_prefix_sums(T, CurrentSum + H, [CurrentSum + H | Acc]).
make_prefix_sums([], _, Acc) ->
    lists:reverse(Acc).

find_length(Query, PrefixSums) ->
    find_length_recursive(Query, PrefixSums, 0).

find_length_recursive(_Query, [], AccLen) ->
    AccLen;
find_length_recursive(Query, [H|T], AccLen) when H =< Query ->
    find_length_recursive(Query, T, AccLen + 1);
find_length_recursive(_Query, [_|_], AccLen) ->
    AccLen.