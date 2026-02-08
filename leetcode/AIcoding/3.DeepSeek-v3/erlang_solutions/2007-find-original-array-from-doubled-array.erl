-module(solution).
-export([find_original_array/1]).

find_original_array(Changed) ->
    case length(Changed) rem 2 of
        1 -> [];
        0 ->
            Freq = lists:foldl(fun(N, Acc) -> 
                maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, Changed),
            Sorted = lists:sort(Changed),
            process(Sorted, Freq, [])
    end.

process([], _, Acc) -> Acc;
process([N | Rest], Freq, Acc) ->
    case maps:get(N, Freq, 0) of
        0 -> process(Rest, Freq, Acc);
        _ ->
            Double = 2 * N,
            case maps:get(Double, Freq, 0) of
                0 -> [];
                _ ->
                    NewFreq = decrement(Freq, N),
                    NewFreq2 = decrement(NewFreq, Double),
                    process(Rest, NewFreq2, [N | Acc])
            end
    end.

decrement(Freq, Key) ->
    case maps:get(Key, Freq) - 1 of
        0 -> maps:remove(Key, Freq);
        V -> maps:put(Key, V, Freq)
    end.