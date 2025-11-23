-module(solution).
-export([max_frequency/1]).

max_frequency(Nums) ->
    {MaxFreq, _, _} = lists:foldl(fun(N, {Max, Freq, Prev}) ->
        case N of
            Prev ->
                NewFreq = Freq + 1,
                {max(Max, NewFreq), NewFreq, Prev};
            _ ->
                {max(Max, 1), 1, N}
        end
    end, {1, 1, hd(Nums)}, tl(Nums)),
    MaxFreq.