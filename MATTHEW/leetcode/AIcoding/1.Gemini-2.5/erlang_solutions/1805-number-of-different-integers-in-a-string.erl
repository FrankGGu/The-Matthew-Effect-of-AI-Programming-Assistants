-module(solution).
-export([countDifferentIntegers/1]).

countDifferentIntegers(Word) ->
    count_integers_recursive(Word, [], sets:new()).

count_integers_recursive([], Acc, Set) ->
    case Acc of
        [] -> sets:size(Set);
        _ -> sets:size(sets:add(normalize_number(lists:reverse(Acc)), Set))
    end;
count_integers_recursive([H|T], Acc, Set) ->
    case is_digit(H) of
        true ->
            count_integers_recursive(T, [H|Acc], Set);
        false ->
            case Acc of
                [] ->
                    count_integers_recursive(T, [], Set);
                _ ->
                    NormalizedNum = normalize_number(lists:reverse(Acc)),
                    NewSet = sets:add(NormalizedNum, Set),
                    count_integers_recursive(T, [], NewSet)
            end
    end.

is_digit(C) when C >= $0, C <= $9 -> true;
is_digit(_) -> false.

normalize_number(NumStr) ->
    trim_leading_zeros(NumStr).

trim_leading_zeros("0") -> "0";
trim_leading_zeros("0" ++ Rest) -> trim_leading_zeros(Rest);
trim_leading_zeros(NumStr) -> NumStr.