-module(solution).
-export([kthDistinct/2]).

kthDistinct(Arr, K) ->
    Counts = lists:foldl(
        fun(String, Acc) ->
            maps:update_with(String, fun(Val) -> Val + 1 end, 1, Acc)
        end,
        maps:new(),
        Arr
    ),

    find_kth(Arr, K, Counts).

find_kth([], _K, _Counts) ->
    <<"">>;
find_kth([H|T], K, Counts) ->
    Count = maps:get(H, Counts),
    if
        Count == 1 ->
            if
                K == 1 ->
                    H;
                true ->
                    find_kth(T, K - 1, Counts)
            end;
        true ->
            find_kth(T, K, Counts)
    end.