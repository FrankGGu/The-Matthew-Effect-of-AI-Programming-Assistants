-spec steps_to_non_decreasing([integer()]) -> integer().
steps_to_non_decreasing(Nums) ->
    steps_to_non_decreasing(Nums, 0).

steps_to_non_decreasing(Nums, Steps) ->
    case is_non_decreasing(Nums) of
        true -> Steps;
        false ->
            {NewNums, Changed} = remove_elements(Nums),
            case Changed of
                true -> steps_to_non_decreasing(NewNums, Steps + 1);
                false -> Steps
            end
    end.

is_non_decreasing([_]) -> true;
is_non_decreasing([X, Y | Rest]) when X =< Y -> is_non_decreasing([Y | Rest]);
is_non_decreasing(_) -> false.

remove_elements(Nums) ->
    remove_elements(Nums, [], false).

remove_elements([], Acc, Changed) -> {lists:reverse(Acc), Changed};
remove_elements([X], Acc, Changed) -> {lists:reverse([X | Acc]), Changed};
remove_elements([X, Y | Rest], Acc, Changed) when X > Y ->
    remove_elements([X | Rest], Acc, true);
remove_elements([X, Y | Rest], Acc, Changed) ->
    remove_elements([Y | Rest], [X | Acc], Changed).