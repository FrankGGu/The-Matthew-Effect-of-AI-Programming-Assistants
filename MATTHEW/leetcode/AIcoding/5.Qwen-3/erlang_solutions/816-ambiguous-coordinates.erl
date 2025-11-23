-module(ambiguous_coordinates).
-export([possible_permutations/1]).

possible_permutations(S) ->
    possible_permutations(S, 1, length(S) - 1).

possible_permutations(_, _, N) when N < 1 ->
    [];
possible_permutations(S, Start, End) ->
    lists:flatmap(fun (I) ->
        A = substring(S, Start, I),
        B = substring(S, I + 1, End),
        case is_valid(A) of
            true ->
                case is_valid(B) of
                    true ->
                        lists:map(fun (X) -> {X, B} end, generate_numbers(A));
                    false ->
                        []
                end;
            false ->
                []
        end
    end, lists:seq(Start, End - 1)) ++ possible_permutations(S, Start + 1, End).

substring(S, Start, End) ->
    string:substr(S, Start, End - Start + 1).

is_valid(N) ->
    case string:split(N, ".", all) of
        [N] ->
            is_integer(N);
        [IntPart, DecPart] ->
            is_integer(IntPart) andalso is_decimal(DecPart)
    end.

is_integer(S) ->
    case string:to_integer(S) of
        {Int, ""} when Int >= 0 ->
            true;
        _ ->
            false
    end.

is_decimal(S) ->
    case string:to_integer(S) of
        {_, ""} ->
            true;
        _ ->
            false
    end.

generate_numbers(S) ->
    case string:split(S, ".", all) of
        [S] ->
            [S];
        [IntPart, DecPart] ->
            [IntPart ++ "." ++ DecPart]
    end.