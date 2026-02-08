-module(solution).
-export([permute_unique/1]).

permute_unique(List) ->
    SortedList = lists:sort(List),
    lists:usort(permute(SortedList)).

permute([]) -> [[]];
permute(List) ->
    [H | T] = List,
    [H1 | T1] = lists:splitwith(fun(X) -> X =:= H end, T),
    lists:flatmap(fun(H) -> 
        lists:map(fun(P) -> [H | P] end, permute(T1)) 
    end, H1).

usort(List) ->
    lists:foldl(fun(X, Acc) -> if lists:member(X, Acc) -> Acc; true -> [X | Acc] end end, [], List).