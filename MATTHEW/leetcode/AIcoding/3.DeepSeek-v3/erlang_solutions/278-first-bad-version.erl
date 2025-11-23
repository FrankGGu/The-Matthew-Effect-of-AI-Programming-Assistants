-spec first_bad_version(N :: integer()) -> integer().
first_bad_version(N) ->
    BinSearch = fun(Start, End) ->
        if 
            Start == End -> Start;
            true ->
                Mid = Start + (End - Start) div 2,
                case isBadVersion(Mid) of
                    true -> BinSearch(Start, Mid);
                    false -> BinSearch(Mid + 1, End)
                end
        end
    end,
    BinSearch(1, N).