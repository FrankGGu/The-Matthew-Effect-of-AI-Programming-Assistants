-module(solution).
-export([num_decodings/1]).

num_decodings(S) ->
    N = length(S),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(N, 1, DP),
    DP2 = case N >= 1 of
        true ->
            LastChar = lists:nth(N, S),
            case LastChar of
                $0 -> array:set(N - 1, 0, DP1);
                _ -> array:set(N - 1, 1, DP1)
            end;
        false -> DP1
    end,
    {Res, _} = lists:foldl(fun(I, {Acc, PrevDP}) ->
        Char = lists:nth(I, S),
        NextChar = case I < N of true -> lists:nth(I + 1, S); false -> $0 end,
        Single = case Char of
            $0 -> 0;
            $* -> 9 * array:get(I + 1, PrevDP);
            _ -> array:get(I + 1, PrevDP)
        end,
        Double = if
            I + 1 > N -> 0;
            true ->
                case {Char, NextChar} of
                    {$1, $*} -> 9 * array:get(I + 2, PrevDP);
                    {$2, $*} -> 6 * array:get(I + 2, PrevDP);
                    {$*, $*} -> 15 * array:get(I + 2, PrevDP);
                    {$*, C} when C >= $0, C =< $6 -> 2 * array:get(I + 2, PrevDP);
                    {$*, C} when C >= $7, C =< $9 -> array:get(I + 2, PrevDP);
                    {$1, C} when C >= $0, C =< $9 -> array:get(I + 2, PrevDP);
                    {$2, C} when C >= $0, C =< $6 -> array:get(I + 2, PrevDP);
                    _ -> 0
                end
        end,
        Total = (Single + Double) rem 1000000007,
        NewDP = array:set(I, Total, PrevDP),
        {Total, NewDP}
    end, {array:get(1, DP2), DP2}, lists:seq(N - 1, 1, -1)),
    Res.