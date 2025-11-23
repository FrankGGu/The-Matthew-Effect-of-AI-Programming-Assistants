-module(solution).
-export([sum_of_number_and_its_reverse/1]).

-spec sum_of_number_and_its_reverse(Num :: integer()) -> boolean().
sum_of_number_and_its_reverse(Num) ->
    check_range(0, Num).

check_range(I, Num) when I =< Num ->
    RevI = reverse_integer(I),
    case I + RevI of
        Num -> true;
        _ -> check_range(I + 1, Num)
    end;
check_range(_I, _Num) ->
    false.

reverse_integer(N) ->
    list_to_integer(lists:reverse(integer_to_list(N))).