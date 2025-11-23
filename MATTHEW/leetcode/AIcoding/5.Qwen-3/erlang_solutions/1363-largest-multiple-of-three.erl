-module(largest_multiple_of_three).
-export([largest_multiple_of_three/1]).

largest_multiple_of_three(Nums) ->
    Sorted = lists:sort(Nums),
    Sum = lists:sum(Sorted),
    case Sum rem 3 of
        0 -> format_result(Sorted);
        _ -> 
            case find_and_remove(Sorted, Sum rem 3) of
                {ok, NewSorted} -> format_result(NewSorted);
                error -> 
                    case Sum rem 3 of
                        1 -> remove_one_or_two(Sorted, 1);
                        2 -> remove_one_or_two(Sorted, 2)
                    end
            end
    end.

format_result([]) -> "0";
format_result(List) -> 
    case lists:all(fun(X) -> X == 0 end, List) of
        true -> "0";
        false -> lists:flatten(lists:map(fun integer_to_list/1, List))
    end.

find_and_remove([], _) -> error;
find_and_remove([H | T], Target) ->
    if H rem 3 == Target -> {ok, T};
       true -> find_and_remove(T, Target)
    end.

remove_one_or_two([], _) -> "0";
remove_one_or_two([H | T], 1) ->
    case lists:member(H, [1,4,7]) of
        true -> format_result(T);
        false -> remove_one_or_two(T, 1)
    end;
remove_one_or_two([H | T], 2) ->
    case lists:member(H, [2,5,8]) of
        true -> format_result(T);
        false -> remove_one_or_two(T, 2)
    end.