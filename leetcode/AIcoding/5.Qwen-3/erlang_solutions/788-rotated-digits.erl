-module(rotated_digits).
-export([num_rotated_digits/1]).

num_rotated_digits(N) ->
    count(1, N, 0).

count(I, N, Acc) when I > N ->
    Acc;
count(I, N, Acc) ->
    case is_valid(I) of
        true -> count(I + 1, N, Acc + 1);
        false -> count(I + 1, N, Acc)
    end.

is_valid(N) ->
    is_valid(integer_to_list(N), [], []).

is_valid([], _, _) ->
    false;
is_valid([C | T], Valid, Invalid) ->
    case C of
        $1 -> is_valid(T, [C | Valid], Invalid);
        $2 -> is_valid(T, [C | Valid], Invalid);
        $5 -> is_valid(T, [C | Valid], Invalid);
        $6 -> is_valid(T, [C | Valid], Invalid);
        $8 -> is_valid(T, [C | Valid], Invalid);
        $9 -> is_valid(T, [C | Valid], Invalid);
        $0 -> is_valid(T, [C | Valid], Invalid);
        _ -> is_valid(T, Valid, [C | Invalid])
    end.

is_valid(_, Valid, Invalid) ->
    lists:member($2, Valid) orelse lists:member($5, Valid) orelse lists:member($6, Valid) orelse lists:member($9, Valid).