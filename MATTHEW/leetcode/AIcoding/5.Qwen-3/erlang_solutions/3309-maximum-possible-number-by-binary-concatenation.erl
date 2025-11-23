-module(solution).
-export([max_number/1]).

max_number(Numbers) ->
    Sorted = lists:sort(Numbers, fun(A, B) -> 
        A_str = integer_to_list(A),
        B_str = integer_to_list(B),
        A_len = length(A_str),
        B_len = length(B_str),
        case A_len - B_len of
            0 -> A_str >= B_str;
            _ -> A_len > B_len
        end
    end),
    lists:foldl(fun(N, Acc) -> Acc ++ integer_to_list(N) end, "", Sorted).