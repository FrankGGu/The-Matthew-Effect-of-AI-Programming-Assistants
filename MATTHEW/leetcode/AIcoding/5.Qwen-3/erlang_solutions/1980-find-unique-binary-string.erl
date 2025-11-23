-module(solution).
-export([find_unique_binary_string/1]).

find_unique_binary_string(Nums) ->
    N = length(Nums),
    Set = sets:from_list(Nums),
    find_unique(Set, N, 0).

find_unique(_, _, N) when N > 0 -> 
    <<N:16/big/native>>.
find_unique(Set, N, I) ->
    BinStr = integer_to_binary(I, 2),
    if
        length(BinStr) < N -> 
            BinStrPadded = string:pad(BinStr, N, $0),
            case sets:is_element(BinStrPadded, Set) of
                true -> find_unique(Set, N, I + 1);
                false -> BinStrPadded
            end;
        true -> find_unique(Set, N, I + 1)
    end.

integer_to_binary(N, Base) ->
    integer_to_binary(N, Base, []).

integer_to_binary(0, _, Acc) ->
    lists:reverse(Acc);
integer_to_binary(N, Base, Acc) ->
    integer_to_binary(N div Base, Base, [digit_to_char(N rem Base) | Acc]).

digit_to_char(D) when D < 10 -> $0 + D;
digit_to_char(D) -> $a + (D - 10).