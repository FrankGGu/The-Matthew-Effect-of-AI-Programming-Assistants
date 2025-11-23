-spec find_second_minimum_value(Root :: #tree_node{} | null) -> integer().
find_second_minimum_value(Root) ->
    case Root of
        null -> -1;
        _ ->
            Values = collect_values(Root),
            UniqueValues = lists:usort(Values),
            case length(UniqueValues) >= 2 of
                true -> lists:nth(2, UniqueValues);
                false -> -1
            end
    end.

collect_values(null) -> [];
collect_values(#tree_node{val = Val, left = Left, right = Right}) ->
    [Val | collect_values(Left) ++ collect_values(Right)].