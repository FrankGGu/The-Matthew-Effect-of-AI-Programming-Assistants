-spec get_strongest(Arr :: [integer()], K :: integer()) -> [integer()].
get_strongest(Arr, K) ->
    Sorted = lists:sort(Arr),
    N = length(Sorted),
    Median = lists:nth((N + 1) div 2, Sorted),
    WithStrength = lists:map(fun(X) -> {abs(X - Median), X} end, Sorted),
    SortedByStrength = lists:sort(fun({A, X}, {B, Y}) -> 
                                     if A > B -> true;
                                        A == B -> X > Y;
                                        true -> false
                                     end
                                  end, WithStrength),
    Strongest = lists:sublist(SortedByStrength, K),
    lists:map(fun({_, X}) -> X end, Strongest).