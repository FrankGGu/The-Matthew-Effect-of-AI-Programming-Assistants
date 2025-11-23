-module(solution).
-export([answer/2]).

answer(Queries, nums) ->
    Sorted = lists:sort(nums),
    Prefix = prefix_sums(Sorted, 0, []),
    [find_max_length(Query, Prefix) || Query <- Queries].

prefix_sums([], _, Acc) ->
    lists:reverse(Acc);
prefix_sums([H | T], Sum, Acc) ->
    NewSum = Sum + H,
    prefix_sums(T, NewSum, [NewSum | Acc]).

find_max_length(Query, Prefix) ->
    find_max_length(Query, Prefix, 0, length(Prefix)).

find_max_length(_, [], _, _) ->
    0;
find_max_length(Query, [H | T], Left, Right) ->
    if
        H =< Query ->
            Left + 1;
        true ->
            find_max_length(Query, T, Left + 1, Right - 1)
    end.