-spec find_closest_elements(Arr :: [integer()], K :: integer(), X :: integer()) -> [integer()].
find_closest_elements(Arr, K, X) ->
    Left = 0,
    Right = length(Arr) - K,
    binary_search(Arr, K, X, Left, Right).

binary_search(Arr, K, X, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    case abs(lists:nth(Mid + 1, Arr) - X) > abs(lists:nth(Mid + K + 1, Arr) - X) of
        true -> binary_search(Arr, K, X, Mid + 1, Right);
        false -> binary_search(Arr, K, X, Left, Mid)
    end;
binary_search(Arr, K, _X, Left, _Right) ->
    lists:sublist(Arr, Left + 1, K).