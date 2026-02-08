-module(solution).
-export([take_k_of_each/2]).

take_k_of_each(S, K) ->
    take_k_of_each(S, K, 0, 0, 0).

take_k_of_each([], _, _, _, Acc) ->
    Acc;
take_k_of_each([H | T], K, LeftCount, RightCount, Acc) ->
    case H of
        $a ->
            if
                LeftCount < K ->
                    take_k_of_each(T, K, LeftCount + 1, RightCount, Acc + 1);
                RightCount < K ->
                    take_k_of_each(T, K, LeftCount, RightCount + 1, Acc + 1)
            end;
        $b ->
            if
                LeftCount < K ->
                    take_k_of_each(T, K, LeftCount + 1, RightCount, Acc + 1);
                RightCount < K ->
                    take_k_of_each(T, K, LeftCount, RightCount + 1, Acc + 1)
            end;
        $c ->
            if
                LeftCount < K ->
                    take_k_of_each(T, K, LeftCount + 1, RightCount, Acc + 1);
                RightCount < K ->
                    take_k_of_each(T, K, LeftCount, RightCount + 1, Acc + 1)
            end;
        _ ->
            take_k_of_each(T, K, LeftCount, RightCount, Acc)
    end.