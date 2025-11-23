-module(solution).
-export([count_stepping_numbers/2]).

count_stepping_numbers(A, B) ->
    count_stepping_numbers(A, B, 0).

count_stepping_numbers(A, B, Count) when A > B ->
    Count;
count_stepping_numbers(A, B, Count) ->
    NewCount = case is_stepping_number(A) of
        true -> Count + 1;
        false -> Count
    end,
    count_stepping_numbers(A + 1, B, NewCount).

is_stepping_number(N) ->
    is_stepping_number_helper(integer_to_list(N)).

is_stepping_number_helper([]) -> true;
is_stepping_number_helper([_]) -> true;
is_stepping_number_helper([H1, H2 | T]) ->
    case abs(H1 - H2) of
        1 -> is_stepping_number_helper([H2 | T]);
        _ -> false
    end.