-module(reconstruct_tree).
-export([number_of_ways/1]).

number_of_ways(Edges) ->
    N = length(Edges) + 1,
    Degree = maps:from_list([{I, 0} || I <- lists:seq(1, N)]),
    EdgesList = [lists:sort(E) || E <- Edges],
    Pairs = lists:usort(EdgesList),
    Nodes = lists:seq(1, N),
    Valid = valid_pairs(Pairs, Nodes),
    case Valid of
        true -> count_ways(Pairs, N);
        false -> 0
    end.

valid_pairs([], _) -> true;
valid_pairs([H | T], Nodes) ->
    {A, B} = H,
    case lists:member(A, Nodes) andalso lists:member(B, Nodes) of
        true -> valid_pairs(T, Nodes -- [A, B]);
        false -> false
    end.

count_ways(Pairs, N) ->
    Count = 1,
    count_ways(Pairs, N, Count).

count_ways([], _, Count) -> Count;
count_ways([H | T], N, Count) ->
    {A, B} = H,
    case A == B of
        true -> count_ways(T, N, Count);
        false ->
            NewCount = Count * (N - 2),
            count_ways(T, N, NewCount)
    end.