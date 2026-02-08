-spec find_special_integer(Arr :: [integer()]) -> integer().
find_special_integer(Arr) ->
    N = length(Arr),
    Threshold = N div 4,
    find_special(Arr, 1, Threshold).

find_special([H | T], Count, Threshold) ->
    case T of
        [] ->
            H;
        [H | _] ->
            find_special(T, Count + 1, Threshold);
        _ ->
            if
                Count > Threshold -> H;
                true -> find_special(T, 1, Threshold)
            end
    end.