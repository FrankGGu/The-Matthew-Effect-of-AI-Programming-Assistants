-module(maximum_number_of_groups_with_increasing_length).
-export([max_gcd_pair/1]).

max_gcd_pair(Numbers) ->
    lists:foldl(fun(N, Acc) -> 
        case Acc of
            [] -> [N];
            _ -> [N | Acc]
        end
    end, [], lists:reverse(lists:sort(Numbers))).

max_groups([]) -> 0;
max_groups([H|T]) ->
    max_groups(T, H, 1, 0).

max_groups([], _, _, Count) -> Count;
max_groups([H|T], Last, Length, Count) ->
    if
        H > Last ->
            max_groups(T, H, Length + 1, Count + 1);
        true ->
            max_groups(T, Last, Length, Count)
    end.

max_gcd_pair(Numbers) ->
    Sorted = lists:sort(Numbers),
    max_groups(Sorted).