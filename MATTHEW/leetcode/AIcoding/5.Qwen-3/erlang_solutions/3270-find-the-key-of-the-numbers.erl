-module(solution).
-export([find_key/1]).

find_key(Numbers) ->
    find_key(Numbers, 0).

find_key([], _) ->
    -1;
find_key([H | T], Index) ->
    case is_key(H, T, Index) of
        true ->
            Index;
        false ->
            find_key(T, Index + 1)
    end.

is_key(Number, List, Index) ->
    lists:all(fun(X) -> X >= Number end, List) andalso
    lists:all(fun(X) -> X <= Number end, lists:sublist(List, Index)).

sublist(_, 0) ->
    [];
sublist([H | T], N) ->
    [H | sublist(T, N - 1)].