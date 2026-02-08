-spec make_array_zero(Nums :: [integer()], K :: integer()) -> boolean().
make_array_zero(Nums, K) ->
    N = length(Nums),
    Diff = array:new(N + 1, [{default, 0}]),
    process_diff(Nums, K, Diff, 0, N).

process_diff([], _, Diff, Current, N) ->
    check_zero(Diff, Current, N);
process_diff([Num | Rest], K, Diff, Current, N) ->
    Index = Current + 1,
    CurrentVal = array:get(Index - 1, Diff),
    NewCurrent = CurrentVal + Num,
    case NewCurrent < 0 orelse (Index + K - 1 > N andalso NewCurrent /= 0) of
        true -> false;
        false ->
            NewDiff = case Index + K =< N of
                true -> 
                    array:set(Index + K, array:get(Index + K, Diff) - Num, Diff);
                false -> Diff
            end,
            NewDiff2 = array:set(Index, NewCurrent, NewDiff),
            process_diff(Rest, K, NewDiff2, Index, N)
    end.

check_zero(Diff, Current, N) ->
    case Current > N of
        true -> true;
        false ->
            case array:get(Current, Diff) of
                0 -> check_zero(Diff, Current + 1, N);
                _ -> false
            end
    end.