-spec prev_perm_opt1(Arr :: [integer()]) -> [integer()].
prev_perm_opt1(Arr) ->
    List = Arr,
    N = length(List),
    case N of
        0 -> List;
        1 -> List;
        _ ->
            {I, J} = find_swap_indices(List, N),
            swap(List, I, J)
    end.

find_swap_indices(List, N) ->
    find_swap_indices(List, N, N - 1, -1, -1).

find_swap_indices(_, _, I, IRes, JRes) when I < 0 ->
    {IRes, JRes};
find_swap_indices(List, N, I, IRes, JRes) ->
    if
        I > 0 ->
            case lists:nth(I, List) > lists:nth(I + 1, List) of
                true ->
                    {NewI, NewJ} = find_largest_smaller(List, I, N, I + 1, I + 1),
                    {NewI, NewJ};
                false ->
                    find_swap_indices(List, N, I - 1, IRes, JRes)
            end;
        true ->
            find_swap_indices(List, N, I - 1, IRes, JRes)
    end.

find_largest_smaller(List, I, N, J, MaxJ) ->
    if
        J > N ->
            {I, MaxJ};
        true ->
            Current = lists:nth(J, List),
            MaxVal = lists:nth(MaxJ, List),
            IVal = lists:nth(I, List),
            if
                Current < IVal, Current > MaxVal ->
                    find_largest_smaller(List, I, N, J + 1, J);
                true ->
                    find_largest_smaller(List, I, N, J + 1, MaxJ)
            end
    end.

swap(List, I, J) ->
    {BeforeI, [IVal | AfterI]} = lists:split(I - 1, List),
    {BeforeJ, [JVal | AfterJ]} = lists:split(J - I - 1, AfterI),
    lists:append([BeforeI, [JVal], BeforeJ, [IVal], AfterJ]).