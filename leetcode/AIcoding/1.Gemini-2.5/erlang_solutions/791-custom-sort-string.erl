-module(solution).
-export([custom_sort_string/2]).

-spec custom_sort_string(S :: string(), T :: string()) -> string().
custom_sort_string(S, T) ->
    % Step 1: Count characters in T
    T_counts = lists:foldl(
        fun(C, Acc) ->
            maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
        end,
        #{},
        T
    ),

    % Step 2: Build the part of the result based on S, and update T_counts
    % Result is {SortedPart, RemainingCountsMap}
    {SortedPart, RemainingCountsMap} = lists:foldl(
        fun(C, {AccList, AccMap}) ->
            case maps:find(C, AccMap) of
                {ok, Count} ->
                    NewAccList = AccList ++ lists:duplicate(Count, C),
                    NewAccMap = maps:remove(C, AccMap),
                    {NewAccList, NewAccMap};
                error -> % C is in S but not in T, or its count was already processed/zero
                    {AccList, AccMap}
            end
        end,
        {[], T_counts},
        S
    ),

    % Step 3: Append remaining characters from T (those not in S)
    RemainingPart = lists:foldl(
        fun({C, Count}, Acc) ->
            Acc ++ lists:duplicate(Count, C)
        end,
        [],
        maps:to_list(RemainingCountsMap)
    ),

    % Step 4: Concatenate the two parts to get the final sorted string
    SortedPart ++ RemainingPart.