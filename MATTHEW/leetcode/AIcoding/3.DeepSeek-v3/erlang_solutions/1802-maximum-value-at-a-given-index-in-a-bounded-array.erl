-spec max_value(N :: integer(), Index :: integer(), MaxSum :: integer()) -> integer().
max_value(N, Index, MaxSum) ->
    Left = Index,
    Right = N - Index - 1,
    Low = 1,
    High = MaxSum,
    binary_search(Low, High, Left, Right, MaxSum).

binary_search(Low, High, Left, Right, MaxSum) ->
    if
        Low > High -> High;
        true ->
            Mid = (Low + High) div 2,
            case calculate_sum(Mid, Left) + calculate_sum(Mid, Right) + Mid =< MaxSum of
                true -> binary_search(Mid + 1, High, Left, Right, MaxSum);
                false -> binary_search(Low, Mid - 1, Left, Right, MaxSum)
            end
    end.

calculate_sum(Value, Length) ->
    if
        Value > Length ->
            (Value + Value - Length) * (Length + 1) div 2;
        true ->
            (Value + 1) * Value div 2 + (Length - Value)
    end.