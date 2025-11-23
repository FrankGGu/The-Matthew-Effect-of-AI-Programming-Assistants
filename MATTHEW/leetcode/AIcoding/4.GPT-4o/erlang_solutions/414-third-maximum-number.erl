-module(solution).
-export([third_max/1]).

-spec third_max([integer()]) -> integer().
third_max(Nums) ->
    %% Remove duplicates and sort in descending order
    Sorted = lists:sort(fun(A, B) -> A > B end, lists:usort(Nums)),
    %% If there are fewer than 3 distinct numbers, return the maximum
    case length(Sorted) of
        L when L < 3 -> hd(Sorted);
        _ -> lists:nth(3, Sorted)
    end.
