-spec longest_subarray(Nums :: [integer()]) -> integer().
longest_subarray(Nums) ->
    longest_subarray(Nums, 0, 0, 0, false).

longest_subarray([], Max, Current, Prev, _) ->
    erlang:max(Max, Current + Prev) - 1;
longest_subarray([1 | T], Max, Current, Prev, Deleted) ->
    case Deleted of
        true -> longest_subarray(T, Max, Current + 1, Prev, Deleted);
        false -> longest_subarray(T, Max, Current + 1, Prev, Deleted)
    end;
longest_subarray([0 | T], Max, Current, Prev, Deleted) ->
    case Deleted of
        true -> 
            NewMax = erlang:max(Max, Current + Prev),
            longest_subarray(T, NewMax, 0, Current, false);
        false ->
            longest_subarray(T, Max, 0, Current, true)
    end.