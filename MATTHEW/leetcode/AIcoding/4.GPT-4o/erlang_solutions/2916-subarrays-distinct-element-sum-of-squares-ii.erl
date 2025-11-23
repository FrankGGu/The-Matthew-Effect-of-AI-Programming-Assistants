-module(solution).
-export([subarrays_distinct_element_sum_of_squares_ii/1]).

subarrays_distinct_element_sum_of_squares_ii(List) ->
    N = length(List),
    Subarrays = lists:seq(1, N),
    lists:sum(lists:map(fun (X) -> 
        lists:sum(lists:map(fun (Y) -> 
            case lists:sublist(List, X - 1, Y) of
                Sub -> distinct_sum_of_squares(Sub)
            end
        end, lists:seq(1, N - X + 1)))
    end, Subarrays)).

distinct_sum_of_squares(Sub) ->
    Distinct = lists:usort(Sub),
    lists:sum(lists:map(fun (X) -> X * X end, Distinct)).