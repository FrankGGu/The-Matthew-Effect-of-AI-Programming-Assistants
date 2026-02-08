-spec find_longest_chain(Pairs :: [[integer()]]) -> integer().
find_longest_chain(Pairs) ->
    Sorted = lists:sort(fun([_, A], [_, B]) -> A =< B end, Pairs),
    find_longest_chain(Sorted, -1001, 0).

find_longest_chain([], _, Count) ->
    Count;
find_longest_chain([[A, B] | Rest], Last, Count) when A > Last ->
    find_longest_chain(Rest, B, Count + 1);
find_longest_chain([_ | Rest], Last, Count) ->
    find_longest_chain(Rest, Last, Count).