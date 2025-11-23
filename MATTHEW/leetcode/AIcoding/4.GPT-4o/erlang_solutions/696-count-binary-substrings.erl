-module(solution).
-export([countBinarySubstrings/1]).

countBinarySubstrings(S) ->
    Groups = count_groups(S, [], []),
    count_substrings(Groups).

count_groups([], Acc, Groups) ->
    lists:reverse([{length(Group) || Group <- Acc} | Groups];
count_groups([H | T], [], Groups) ->
    count_groups(T, [[H]], Groups);
count_groups([H | T], [Prev | Acc], Groups) when H =:= Prev ->
    count_groups(T, [[H | Prev] | Acc], Groups);
count_groups([H | T], [Prev | Acc], Groups) ->
    count_groups(T, [[H], Prev | Acc], Groups).

count_substrings([]) -> 0;
count_substrings([_]) -> 0;
count_substrings([H1, H2 | T]) -> 
    count_substrings([H2 | T]) + min(H1, H2).

min(A, B) -> 
    if 
        A < B -> A; 
        true -> B 
    end.