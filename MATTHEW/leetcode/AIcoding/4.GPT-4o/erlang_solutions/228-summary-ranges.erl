-spec summary_ranges(Nums :: [integer()]) -> [unicode:unicode_binary()].
summary_ranges([]) -> [];
summary_ranges([Single]) -> [integer_to_list(Single)];
summary_ranges([First, Second | Rest]) when Second =:= First + 1 ->
    RangeList = collect_range([First, Second], Rest),
    list_to_range_string(RangeList);
summary_ranges([First, Second | Rest]) ->
    [integer_to_list(First) | summary_ranges([Second | Rest])].


collect_range([First, Second], [Third | Rest]) when Third =:= Second + 1 ->
    collect_range([First, Second, Third], Rest);
collect_range([First, Second], Rest) ->
    [[First, Second] | Rest].

list_to_range_string([[First, First]]) -> [integer_to_list(First)];
list_to_range_string([[First, Last]]) -> [integer_to_list(First) ++ "->" ++ integer_to_list(Last)];
list_to_range_string([Head | Tail]) -> 
    list_to_range_string([Head]) ++ list_to_range_string(Tail).
