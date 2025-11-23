-module(seq_digits).
-export([sequential_digits/1]).

sequential_digits(N) ->
    Result = [],
    generate(1, 10, N, Result).

generate(_, _, _, Acc) when length(Acc) >= 100 ->
    lists:sort(Acc);
generate(Start, End, N, Acc) ->
    case Start < End of
        true ->
            Num = generate_number(Start, End),
            if
                length(integer_to_list(Num)) == N ->
                    generate(Start + 1, End, N, [Num | Acc]);
                true ->
                    generate(Start + 1, End, N, Acc)
            end;
        false ->
            generate(1, End + 1, N, Acc)
    end.

generate_number(Start, End) ->
    generate_number(Start, End, []).

generate_number(Start, End, Acc) when Start > End ->
    list_to_integer(lists:reverse(Acc));
generate_number(Start, End, Acc) ->
    generate_number(Start + 1, End, [integer_to_list(Start) | Acc]).