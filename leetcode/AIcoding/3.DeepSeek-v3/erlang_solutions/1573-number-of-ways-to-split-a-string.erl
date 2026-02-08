-module(solution).
-export([num_ways/1]).

num_ways(S) ->
    Ones = lists:filter(fun(X) -> X == $1 end, S),
    Len = length(Ones),
    if
        Len rem 3 =/= 0 -> 0;
        true ->
            case Len of
                0 ->
                    N = length(S),
                    ((N - 1) * (N - 2) div 2) rem 1000000007;
                _ ->
                    K = Len div 3,
                    {First1, _} = find_kth(S, K, 0, 0),
                    {Second1, _} = find_kth(S, K + 1, 0, 0),
                    {First2, _} = find_kth(S, 2 * K, 0, 0),
                    {Second2, _} = find_kth(S, 2 * K + 1, 0, 0),
                    ((Second1 - First1) * (Second2 - First2)) rem 1000000007
            end
    end.

find_kth([], _, Pos, Count) -> {Pos, Count};
find_kth([H|T], K, Pos, Count) ->
    NewCount = if H == $1 -> Count + 1; true -> Count end,
    if
        NewCount == K -> {Pos + 1, NewCount};
        true -> find_kth(T, K, Pos + 1, NewCount)
    end.