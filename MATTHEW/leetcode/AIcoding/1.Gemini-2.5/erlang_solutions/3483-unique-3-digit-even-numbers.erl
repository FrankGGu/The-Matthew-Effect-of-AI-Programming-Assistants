-module(solution).
-export([find_even_numbers/1]).

find_even_numbers(Digits) ->
    OriginalCounts = lists:foldl(
        fun(D, Acc) ->
            maps:update_with(D, fun(V) -> V + 1 end, 1, Acc)
        end,
        #{},
        Digits
    ),
    find_even_numbers_recursive(100, OriginalCounts, []).

find_even_numbers_recursive(Num, OriginalCounts, Acc) when Num > 999 ->
    lists:reverse(Acc);
find_even_numbers_recursive(Num, OriginalCounts, Acc) ->
    D1 = Num div 100,
    D2 = (Num div 10) rem 10,
    D3 = Num rem 10,

    TempCounts = lists:foldl(
        fun(D, TAcc) ->
            maps:update_with(D, fun(V) -> V + 1 end, 1, TAcc)
        end,
        #{},
        [D1, D2, D3]
    ),

    CanForm = maps:all(
        fun(K, V) ->
            V =< maps:get(K, OriginalCounts, 0)
        end,
        TempCounts
    ),

    case CanForm of
        true ->
            find_even_numbers_recursive(Num + 2, OriginalCounts, [Num | Acc]);
        false ->
            find_even_numbers_recursive(Num + 2, OriginalCounts, Acc)
    end.