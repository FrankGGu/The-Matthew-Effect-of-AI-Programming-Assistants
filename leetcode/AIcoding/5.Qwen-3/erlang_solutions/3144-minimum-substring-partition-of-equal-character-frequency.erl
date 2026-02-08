-module(min_substring_partition).
-export([min_substring_partition/1]).

min_substring_partition(S) ->
    min_substring_partition(S, 0, 0, 0, #{}).

min_substring_partition([], _Start, _End, _MinLen, _) ->
    _MinLen;
min_substring_partition(S, Start, End, MinLen, Counts) ->
    case End of
        Len when Len >= length(S) ->
            min_substring_partition(S, Start + 1, Start + 1, MinLen, #{});
        _ ->
            Char = lists:nth(End + 1, S),
            NewCounts = maps:update_with(Char, fun(V) -> V + 1 end, 1, Counts),
            {MaxFreq, _} = lists:foldl(fun({_K, V}, {Max, _}) -> {max(Max, V), _} end, {0, 0}, maps:to_list(NewCounts)),
            if
                MaxFreq * (End - Start + 1) == maps:size(NewCounts) * (End - Start + 1) ->
                    NewMinLen = min(MinLen, End - Start + 1),
                    min_substring_partition(S, Start, End + 1, NewMinLen, NewCounts);
                true ->
                    min_substring_partition(S, Start, End + 1, MinLen, NewCounts)
            end
    end.