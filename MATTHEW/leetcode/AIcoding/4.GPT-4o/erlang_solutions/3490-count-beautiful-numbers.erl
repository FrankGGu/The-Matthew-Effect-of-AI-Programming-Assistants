-module(solution).
-export([count_beautiful_numbers/1]).

count_beautiful_numbers(N) ->
    lists:foldl(fun(X, Acc) -> 
        if 
            is_beautiful(X) -> Acc + 1; 
            true -> Acc
        end 
    end, 0, lists:seq(1, N)).

is_beautiful(X) ->
    case lists:reverse(integer_to_list(X)) of
        [H|T] -> 
            lists:all(fun(D) -> (H rem 2) =:= (D rem 2) end, T);
        [] -> false
    end.