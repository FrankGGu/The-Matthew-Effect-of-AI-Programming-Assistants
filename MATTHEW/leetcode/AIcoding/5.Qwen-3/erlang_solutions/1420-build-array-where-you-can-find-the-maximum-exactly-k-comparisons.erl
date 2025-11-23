-module(solution).
-export([max_array/3]).

max_array(N, K, Target) ->
    max_array(N, K, Target, 1, 0, 0, 0, 0).

max_array(_, _, _, _, _, _, _, Acc) when Acc == 0 ->
    0;
max_array(N, K, Target, Pos, MaxSoFar, Count, Current, Acc) when Pos > N ->
    if
        Count == K -> Acc + 1;
        true -> Acc
    end;
max_array(N, K, Target, Pos, MaxSoFar, Count, Current, Acc) ->
    case Pos of
        1 ->
            max_array(N, K, Target, Pos + 1, Current, Count, Current, Acc);
        _ ->
            lists:foldl(
                fun(Value, Acc2) ->
                    NewMax = max(MaxSoFar, Value),
                    NewCount = if
                        NewMax == Target -> Count + 1;
                        true -> Count
                    end,
                    NewAcc = if
                        NewCount > K -> Acc2;
                        true -> max_array(N, K, Target, Pos + 1, NewMax, NewCount, Value, Acc2)
                    end,
                    NewAcc
                end,
                Acc,
                lists:seq(1, Target)
            )
    end.