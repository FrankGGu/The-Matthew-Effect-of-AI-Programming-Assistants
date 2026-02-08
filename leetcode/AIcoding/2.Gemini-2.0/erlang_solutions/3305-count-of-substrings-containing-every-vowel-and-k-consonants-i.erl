-module(solution).
-export([number_of_substrings/2]).

number_of_substrings(S, K) ->
    number_of_substrings(S, K, 0).

number_of_substrings([], _K, Acc) ->
    Acc;
number_of_substrings(S, K, Acc) ->
    number_of_substrings(S, K, 0, Acc).

number_of_substrings(_, _, _, Acc) when Acc < 0 ->
  0;
number_of_substrings([], _, _, Acc) ->
    Acc;
number_of_substrings(S, K, Start, Acc) ->
    case find_substring(S, K) of
        undefined ->
            Acc;
        {true, End} ->
            Len = length(S);
            number_of_substrings(tl(S), K, Acc + (Len - End +1));
        false ->
            number_of_substrings(tl(S), K, Acc)
    end.

find_substring(S, K) ->
    find_substring(S, K, 1, 0, 0, 0, 0, 0, 0).

find_substring([], _K, End, A, E, I, O, U, Consonants) ->
    case A > 0 andalso E > 0 andalso I > 0 andalso O > 0 andalso U > 0 andalso Consonants >= _K of
        true ->
            {true, End};
        false ->
            false
    end;
find_substring([H|T], K, End, A, E, I, O, U, Consonants) ->
    case H of
        $a ->
            find_substring(T, K, End + 1, A + 1, E, I, O, U, Consonants);
        $e ->
            find_substring(T, K, End + 1, A, E + 1, I, O, U, Consonants);
        $i ->
            find_substring(T, K, End + 1, A, E, I + 1, O, U, Consonants);
        $o ->
            find_substring(T, K, End + 1, A, E, I, O + 1, U, Consonants);
        $u ->
            find_substring(T, K, End + 1, A, E, I, O, U + 1, Consonants);
        _ ->
            case is_consonant(H) of
                true ->
                    find_substring(T, K, End + 1, A, E, I, O, U, Consonants + 1);
                false ->
                    find_substring(T, K, End + 1, A, E, I, O, U, Consonants)
            end
    end.

is_consonant(Char) ->
    case Char of
        $a -> false;
        $e -> false;
        $i -> false;
        $o -> false;
        $u -> false;
        _ ->
            case Char >= $a andalso Char <= $z of
                true -> true;
                false -> false
            end
    end.