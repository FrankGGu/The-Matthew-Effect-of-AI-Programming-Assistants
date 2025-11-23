-spec get_trigger_time(Increase :: [[integer()]], Requirements :: [[integer()]]) -> [integer()].
get_trigger_time(Increase, Requirements) ->
    N = length(Increase),
    M = length(hd(Increase)),
    Prefix = lists:foldl(fun(Inc, Acc) ->
        Last = case Acc of
            [] -> lists:duplicate(M, 0);
            [H|_] -> H
        end,
        New = lists:zipwith(fun(X, Y) -> X + Y end, Last, Inc),
        [New | Acc]
    end, [], Increase),
    PrefixSum = lists:reverse(Prefix),
    lists:map(fun(Req) ->
        binary_search(PrefixSum, Req)
    end, Requirements).

binary_search(List, Target) ->
    binary_search(List, Target, 0, length(List) - 1).

binary_search(List, Target, Left, Right) when Left =< Right ->
    Mid = (Left + Right) div 2,
    MidVal = lists:nth(Mid + 1, List),
    case check(MidVal, Target) of
        true ->
            case Mid =:= 0 orelse not check(lists:nth(Mid, List), Target) of
                true -> Mid;
                false -> binary_search(List, Target, Left, Mid - 1)
            end;
        false ->
            binary_search(List, Target, Mid + 1, Right)
    end;
binary_search(_, _, _, _) ->
    -1.

check([A, B, C], [X, Y, Z]) ->
    A >= X andalso B >= Y andalso C >= Z.