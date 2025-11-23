-module(solution).
-export([get_length_of_optimal_compression/2]).

get_length_of_optimal_compression(S, K) ->
    N = length(S),
    DP = lists:duplicate(N + 1, lists:duplicate(K + 1, 1000)),
    DP1 = set(1, 1, 0, DP),
    DP2 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case I > 1 andalso lists:nth(I, S) == lists:nth(I - 1, S) then
                set(I + 1, J, min(get(I, J, Acc1), get(I + 1, J, Acc1)), Acc1)
            else
                set(I + 1, J, min(get(I, J, Acc1) + 1, get(I + 1, J, Acc1)), Acc1)
            end
        end, Acc, lists:seq(0, K))
    end, DP1, lists:seq(1, N)),
    DP3 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case J > 0 then
                set(I + 1, J + 1, min(get(I + 1, J + 1, Acc1), get(I, J, Acc1)), Acc1)
            else
                Acc1
            end
        end, Acc, lists:seq(0, K))
    end, DP2, lists:seq(1, N)),
    get(N + 1, K, DP3).

set(I, J, Val, DP) ->
    Row = lists:nth(I, DP),
    NewRow = setelement(J + 1, list_to_tuple(Row), Val),
    setelement(I, list_to_tuple(DP), tuple_to_list(NewRow)).

get(I, J, DP) ->
    Row = lists:nth(I, DP),
    lists:nth(J + 1, Row).