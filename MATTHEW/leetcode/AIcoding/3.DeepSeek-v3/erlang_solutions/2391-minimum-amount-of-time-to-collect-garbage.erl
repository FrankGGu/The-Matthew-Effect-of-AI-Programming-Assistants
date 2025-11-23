-spec garbage_collection(Garbage :: [unicode:unicode_binary()], Travel :: [integer()]) -> integer().
garbage_collection(Garbage, Travel) ->
    Types = ["M", "P", "G"],
    lists:sum([calculate_time(Garbage, Travel, Type) || Type <- Types]).

calculate_time(Garbage, Travel, Type) ->
    {Time, LastPos} = lists:foldl(fun
        (House, {AccTime, AccPos}) ->
            case binary:match(House, Type) of
                nomatch ->
                    {AccTime, AccPos};
                _ ->
                    TravelTime = if
                        AccPos =:= -1 -> 0;
                        true -> lists:nth(AccPos, Travel)
                    end,
                    {AccTime + TravelTime + length(binary:bin_to_list(House)), AccPos + 1}
            end
        end, {0, -1}, Garbage),
    Time.