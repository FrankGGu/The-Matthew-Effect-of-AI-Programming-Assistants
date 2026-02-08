-module(solution).
-export([can_convert/3]).

can_convert(S, T, K) ->
    {_Counts, Result} = lists:foldl(
        fun({CharS, CharT}, {AccCounts, AccPossible}) ->
            if not AccPossible ->
                {AccCounts, false}; % If already impossible, propagate false
            true ->
                Diff = (CharT - CharS + 26) rem 26,
                if Diff == 0 ->
                    {AccCounts, AccPossible}; % No move needed for identical characters
                true ->
                    CountForDiff = maps:get(Diff, AccCounts, 0),
                    Cost = Diff + 26 * CountForDiff,
                    if Cost > K ->
                        {AccCounts, false}; % Cost exceeds K, impossible
                    true ->
                        {maps:put(Diff, CountForDiff + 1, AccCounts), true} % Update counts and continue
                    end
                end
            end
        end,
        {#{}, true}, % Initial accumulator: empty map for counts, true for possibility
        lists:zip(S, T)
    ),
    Result.