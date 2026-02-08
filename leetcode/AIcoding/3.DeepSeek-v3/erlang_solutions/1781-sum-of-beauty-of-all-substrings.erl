-spec beauty_sum(S :: unicode:unicode_binary()) -> integer().
beauty_sum(S) ->
    String = unicode:characters_to_list(S),
    N = length(String),
    Sum = lists:sum([
        begin
            Freq = maps:new(),
            Max = 0,
            Min = 0,
            lists:foldl(fun(J, {FreqAcc, CurrentSum}) ->
                Char = lists:nth(J, String),
                NewFreq = maps:update_with(Char, fun(V) -> V + 1 end, 1, FreqAcc),
                CurrentMax = maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, NewFreq),
                CurrentMin = maps:fold(fun(_, V, Acc) -> min(V, Acc) end, infinity, NewFreq),
                {NewFreq, CurrentSum + (CurrentMax - CurrentMin)}
            end, {Freq, 0}, lists:seq(I, N))
        end
        || I <- lists:seq(1, N)
    ]),
    Sum.