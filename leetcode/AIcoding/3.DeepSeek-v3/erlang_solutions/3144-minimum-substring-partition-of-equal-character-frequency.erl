-module(solution).
-export([minimum_substrings/1]).

minimum_substrings(S) ->
    N = length(S),
    DP = array:new([{size, N + 1}, {default, N + 1}]),
    DP1 = array:set(0, 0, DP),
    minimum_substrings(S, 1, N, DP1).

minimum_substrings(S, I, N, DP) when I > N ->
    array:get(N, DP);
minimum_substrings(S, I, N, DP) ->
    Freq = maps:new(),
    {DP1, _} = lists:foldl(fun(J, {DPAcc, FreqAcc}) ->
        Char = lists:nth(J, S),
        FreqNew = maps:update_with(Char, fun(V) -> V + 1 end, 1, FreqAcc),
        case is_valid(FreqNew) of
            true ->
                Prev = array:get(I - 1, DPAcc),
                Curr = array:get(J, DPAcc),
                if
                    Prev + 1 < Curr ->
                        {array:set(J, Prev + 1, DPAcc), FreqNew};
                    true ->
                        {DPAcc, FreqNew}
                end;
            false ->
                {DPAcc, FreqNew}
        end
    end, {DP, Freq}, lists:seq(I, N)),
    minimum_substrings(S, I + 1, N, DP1).

is_valid(Freq) ->
    Values = maps:values(Freq),
    lists:all(fun(V) -> V =:= hd(Values) end, Values).